require 'spec_helper'

describe Naver::Searchad::Api::Core::ApiCommand do
  subject(:this) { described_class.new(method, url) }
  let(:method) { :get }
  let(:url) { 'http://forwrd3d.com' }

  describe '.prepare!' do
    subject(:prepare) { this.prepare! }

    context 'when request_object is not given' do
      it 'should send empty header and body' do
        prepare
        expect(this.header).to eq({})
        expect(this.body).to eq('')
      end
    end

    context 'when request_object is given' do
      before(:each) do
        this.request_object = request_object
      end

      context 'with json string' do
        let(:request_object) { { foo: 'bar' } }

        it 'should send application/json content type header and json body' do
          prepare
          expect(this.header).to eq({'Content-Type' => 'application/json'})
          expect(this.body).to eq('{"foo":"bar"}')
        end
      end
    end
  end

  describe '.decode_response_body' do
    subject(:decode_response_body) { this.decode_response_body(content_type, body) }

    context 'when no content-type is given' do
      let(:content_type) { }
      let(:body) { 'test' }

      it { expect(decode_response_body).to eq('test') }
    end

    context 'when json content-type is not given' do
      let(:content_type) { 'html/text' }
      let(:body) { 'test' }

      it { expect(decode_response_body).to be_nil }
    end

    context 'when all ok' do
      let(:content_type) { 'application/json' }
      let(:body) { '{"foo":"bar"}' }

      it { expect(decode_response_body).to eq({'foo' => 'bar'}) }
    end
  end

  describe 'check_status' do
    subject(:check_status) { this.check_status(404, nil, body) }

    context 'Naver request related api returned' do
      let(:body) { '{"code":1018,"status":404,"title":"No permission to access the resource."}' }

      it { expect{ check_status }.to raise_error(Naver::Searchad::Api::NotEnoughPermissionError) }
    end
  end

  describe '.execute' do
    subject(:execute) { this.execute(Naver::Searchad::Api::Core::BaseService.new('', '').client) }

    context 'when post request with json body' do
      let(:method) { :post }
      let(:request_object) { { 'foo' => 'bar' } }

      before(:each) do
        this.request_object = request_object
        stub_request(:post, url).to_return(status: [200, ''], body: 'post_success')
      end

      it 'should send json content type in header and serialized body' do
        execute
        expect(a_request(:post, url).
            with(headers: { 'Content-Type' => 'application/json' },
                 body: '{"foo":"bar"}')).
            to have_been_made
      end
    end

    context 'when response is JSON format' do
      before(:each) do
        stub_request(:get, url).
          to_return(status: [200, ''],
                    headers: { 'Content-Type' => 'application/json' },
                    body: '{"foo":"bar"}')
      end

      it 'should return decoded body' do
        expect(execute).to eq({ 'foo' => 'bar' })
      end
    end

    context 'when 429 too many requests error with custom messagge is returned' do
      before(:each) do
        stub_request(:get, url).
          to_return(status: [429, ''],
                    body: '{"code":429,"status":429,"title":"Cannot handle the request. Too many requests already exist."}')
      end

      it 'should raise RateLimitError' do
        expect{ execute }.to raise_error(Naver::Searchad::Api::RateLimitError)
      end
    end

    context 'when 1018 request error is returned' do
      before(:each) do
        stub_request(:get, url).
          to_return(status: [404, ''],
                    body: '{"code":1018,"status":404,"title":"No permission to access the resource."}')
      end

      it 'should raise NotEnoughPermissionError' do
        expect{ execute }.to raise_error(Naver::Searchad::Api::NotEnoughPermissionError)
      end
    end
  end
end
