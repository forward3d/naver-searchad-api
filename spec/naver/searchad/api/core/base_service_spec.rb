require 'spec_helper'

describe Naver::Searchad::Api::Core::BaseService do
  subject(:this) { described_class.new('http://forward3d.com/') }

  describe '#user_agent' do
    subject(:user_agent) { this.send(:user_agent) }

    context 'when specific application name/version are given' do
      before do
        Naver::Searchad::Api::ClientOptions.default.application_name = 'test'
        Naver::Searchad::Api::ClientOptions.default.application_version = '99.9'
      end

      it { expect(user_agent).to match(/^test\/99.9/) }

      it 'should inherit default options' do
        expect(this.client_options.application_name).to eq('test')
      end
    end
  end

  describe '#authorization' do
    subject(:authorization) { this.authorization }

    context 'when default authorization option is given' do
      before(:each) do
        Naver::Searchad::Api::RequestOptions.default.authorization = 'auth token'
      end

      it 'should inherit authorization' do
        expect(authorization).to eq('auth token')
      end
    end

    context 'when authorization option is given' do
      before(:each) do
        this.authorization = 'new auth token'
      end

      it 'should allow overriding it' do
        expect(authorization).to eq('new auth token')
      end
    end
  end

  describe '#client' do
    subject(:client) { this.client }

    context 'when proxy default option is given' do
      before(:each) do
        Naver::Searchad::Api::ClientOptions.default.proxy_url = 'http://forward.proxy.com'
      end

      it 'should set given option to proxy url' do
        expect(client.proxy.to_s).to eq('http://forward.proxy.com')
      end
    end

    context 'when connection open timeout option is given' do
      before(:each) do
        Naver::Searchad::Api::ClientOptions.default.open_timeout_sec = 100
      end

      it 'should set given option to connect_timeout' do
        expect(client.connect_timeout).to eq(100)
      end
    end

    context 'when connection read timeout option is given' do
      before(:each) do
        Naver::Searchad::Api::ClientOptions.default.read_timeout_sec = 99
      end

      it 'should set given option to receive_timeout' do
        expect(client.receive_timeout).to eq(99)
      end
    end

    context 'when connection send timeout option is given' do
      before(:each) do
        Naver::Searchad::Api::ClientOptions.default.send_timeout_sec = 98
      end

      it 'should set given option to send_timeout' do
        expect(client.send_timeout).to eq(98)
      end
    end
  end

  describe '#make_command' do
    subject(:make_command) { this.send(:make_command, :get, 'foo/bar', options) }
    let(:options) { { } }

    context 'when custom options given' do
      let(:options) { { header: { 'foo' => 'bar' } } }

      it 'should set the given option to request_options in command' do
        expect(make_command.options.header).to include('foo' => 'bar')
      end
    end

    context 'when all ok' do
      it 'should build a command with relevant url and method' do
        command = make_command
        expect(command.url.expand({}).to_s).to eq('http://forward3d.com/foo/bar')
        expect(command.method).to eq(:get)
      end
    end
  end

  describe '#execute_command' do
    context 'when executing a command with get request' do
      before(:each) do
        stub_request(:get, "http://forward3d.com/foo/bar/100?foo=bar").
          to_return(headers: { }, body: 'Hello')
      end

      it 'should add param to url, query strings, and request to relevant url' do
        expect do |b|
          command = this.send(:make_command, :get, 'foo/bar/{campaign_id}', {})
          command.params['campaign_id'] = 100
          command.query['foo'] = 'bar'
          this.send(:execute_command, command, &b)
        end.to yield_with_args('Hello', nil)
      end
    end

    context 'when executing a command with post request and object' do
      before(:each) do
        stub_request(:post, "http://forward3d.com/foo/bar").
          with(body: '{"campaign":"test-00"}').
            to_return(headers: { 'Content-Type' => 'application/json' },
                      body: '{"result":"ok"}')
      end

      it 'should encode hash to json and decode json to hash' do
        expect do |b|
          command = this.send(:make_command, :post, 'foo/bar', {})
          command.request_object = { 'campaign' => 'test-00' }
          this.send(:execute_command, command, &b)
        end.to yield_with_args({ 'result' => 'ok' }, nil)
      end
    end
  end
end
