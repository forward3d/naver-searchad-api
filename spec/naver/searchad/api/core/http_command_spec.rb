require 'spec_helper'

describe Naver::Searchad::Api::Core::HttpCommand do
  subject(:this) { described_class.new(method, url, body: request_body) }

  describe '.execute' do
    subject(:execute) { this.execute(client) }
    let(:client) { Naver::Searchad::Api::Core::BaseService.new('', '').client }
    let(:url) { 'http://www.forward3d.com' }
    let(:body) { 'Hi Forward3d' }
    let(:header) { { 'Content-Type' => ['html/text'] } }
    let(:status) { 200 }
    let(:method) { :get }
    let(:request_body) { }

    before(:each) do
      stub_request(method, url).
        to_return(status: status, body: body, headers: header)
    end

    context 'when only url is given without any options and get method' do
      let(:url) { 'http://www.forward3d.com/' }
      let(:method) { :get }

      context 'with 200 ok' do
        context 'with block given' do
          it 'should yield with no error and relevant result' do
            expect { |b| this.execute(client, &b) }.to yield_with_args(body, nil)
          end
        end

        context 'without block' do
          it 'should return relevant result' do
            expect(execute).to eq(body)
          end
        end
      end

      context 'with 301 redirect' do
        let(:status) { 301 }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::RedirectError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::RedirectError) }
        end
      end

      context 'with 400 invalid request' do
        let(:status) { 400 }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::RequestError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::RequestError) }
        end
      end

      context 'with 401 unauthorized' do
        let(:status) { 401 }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::AuthorizationError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::AuthorizationError) }
        end
      end

      context 'with 404 not found' do
        let(:status) { 404 }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::RequestError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::RequestError) }
        end
      end

      context 'with 500 internal server error' do
        let(:status) { 500 }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::ServerError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::ServerError) }
        end
      end

      context 'with unknown error code' do
        let(:status) { 600 }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::UnknownError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::UnknownError) }
        end
      end

      context 'with HTTPClient::BadResponseError wrapped error code' do
        before(:each) do
          stub_request(:get, url).
            to_raise(HTTPClient::BadResponseError.new('', double('http_res', status: 404, header: {}, body: '')))
        end

        it { expect{ execute }.to raise_error(Naver::Searchad::Api::RequestError) }
      end

      context 'with HTTPClient::TimeoutError' do
        before(:each) do
          allow(client).to receive(:request) {
            raise HTTPClient::TimeoutError.new
          }
        end

        it { expect{ execute }.to raise_error(Naver::Searchad::Api::TimeoutError) }
      end
    end

    context 'when parameters are given' do
      let(:url) { 'http://www.forward3d.com/{param1}/{param2}' }
      let(:body) { 'Hi Forward3d Careers' }

      before(:each) do
        this.params['param1'] = 'careers'
        this.params['param2'] = 'vacancies'

        stub_request(:get, 'http://www.forward3d.com/careers/vacancies').
            to_return(status: 200, body: body, headers: {})
      end

      it { expect(execute).to eq(body) }
    end

    context 'when query strings given' do
      before(:each) do
        this.query['foo'] = 'bar'
        this.query['foo1'] = 'bar1'
      end

      context 'when no query string in initial url' do
        let(:url) { 'http://www.forward3d.com' }
        before(:each) do
          stub_request(:get, 'http://www.forward3d.com?foo=bar&foo1=bar1').
            to_return(status: 200, body: body, headers: {})
        end

        it { expect(execute).to eq(body) }
      end

      context 'when query string in initial url' do
        let(:url) { 'http://www.forward3d.com?a=1' }
        before(:each) do
          stub_request(:get, 'http://www.forward3d.com?a=1&foo=bar&foo1=bar1').
            to_return(status: 200, body: body, headers: {})
        end

        it { expect(execute).to eq(body) }
      end
    end

    context 'when credentials are given' do
      let(:authorization) do
        auth = double('auth')
        allow(auth).to receive(:apply) do |header|
          header['X-Timestamp'] = timestamp
          header['X-API-KEY'] = api_key
          header['X-Customer'] = customer
          header['X-Signature'] = signature
        end
        auth
      end
      let(:timestamp) { '12121121' }
      let(:api_key) { 'xx2f23f23' }
      let(:customer) { '2232' }
      let(:signature) { 'xxxxx' }

      before(:each) do
        this.options.authorization = authorization
      end

      it 'should send credentials in request header' do
        execute
        expect(a_request(:get, url).
          with(headers: {
            'X-Timestamp' => timestamp,
            'X-API-KEY' => api_key,
            'X-Customer' => customer,
            'X-Signature' => signature
            })).to have_been_made
      end
    end

    context 'when options are given' do
      context 'with customer header' do
        let(:custom_header) { { 'foo' => 'bar' } }
        before(:each) do
          this.options.header = custom_header
        end

        it 'should send the given customer header in request header' do
          execute
          expect(a_request(:get, url).
            with(headers: { 'Foo' => 'bar' })).to have_been_made
        end
      end
    end

    context 'when post method with body given' do
      let(:method) { :post }
      let(:request_body) { '{"foo":"bar"}' }
      before(:each) do
        stub_request(:post, url).with(body: request_body).
          to_return(status: [200, ''], body: 'post_success')
      end

      it 'should send request body in the request' do
        expect(execute).to eq('post_success')
      end
    end
  end
end
