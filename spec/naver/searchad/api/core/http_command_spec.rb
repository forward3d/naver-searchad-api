require 'spec_helper'

describe Naver::Searchad::Api::Core::HttpCommand do
  subject(:this) { described_class.new(method, url) }

  describe '.execute' do
    subject(:execute) { this.execute(client) }
    let(:client) { double('client') }
    let(:body) {  }
    let(:header) { { 'Content-Type' => ['html/text'] } }
    let(:status) { '200' }

    before(:each) do
      allow(client).to receive(:request) {
        double('http_res', status: status, header: header, body: body)
      }
    end

    context 'when only url is given without any options and get method' do
      let(:url) { 'http://www.forward3d.com/' }
      let(:method) { :get }
      let(:body) { 'Hi Forward3d' }

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
        let(:status) { '301' }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::RedirectError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::RedirectError) }
        end
      end

      context 'with 400 invalid request' do
        let(:status) { '400' }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::RequestError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::RequestError) }
        end
      end

      context 'with 401 unauthorized' do
        let(:status) { '401' }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::AuthorizationError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::AuthorizationError) }
        end
      end

      context 'with 404 not found' do
        let(:status) { '404' }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::RequestError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::RequestError) }
        end
      end

      context 'with 500 internal server error' do
        let(:status) { '500' }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::ServerError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::ServerError) }
        end
      end

      context 'with unknown error code' do
        let(:status) { '600' }

        context 'with block given' do
          it { expect { |b| this.execute(client, &b) }.to yield_with_args(nil, Naver::Searchad::Api::UnknownError) }
        end

        context 'without block' do
          it { expect{ execute }.to raise_error(Naver::Searchad::Api::UnknownError) }
        end
      end
    end

    context 'when params and url are given' do

    end
  end
end
