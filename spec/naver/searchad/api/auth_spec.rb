require 'spec_helper'

include Naver::Searchad::Api::Auth

describe CustomerAcccountCredentials do
  subject(:this) { described_class.new(key, secret, custom_id) }
  let(:key) { 'api_key' }
  let(:secret) { 'api_secret' }
  let(:custom_id) { '1077530' }

  describe '#generate_signature' do
    context 'when all ok' do
      it 'should return relevant base64 encoded signature' do
        expect(this.send(:generate_signature, secret, '/foo/bar/', 'get', 111)).
          to match(/(?:[A-Za-z0-9+\/]{4}\\n?)*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)/)
      end
    end
  end

  describe '#apply' do
    context 'when symbol method is given' do
      it 'should set relevant headers' do
        header = {}
        this.apply(header, '/foo/bar', :get)
        expect(header.key?('X-Timestamp')).to eq(true)
        expect(header.key?('X-API-KEY')).to eq(true)
        expect(header.key?('X-Customer')).to eq(true)
        expect(header.key?('X-Signature')).to eq(true)
      end
    end

    context 'when string method is given' do
      it 'should set relevant headers' do
        header = {}
        this.apply(header, '/foo/bar', 'get')
        expect(header.key?('X-Timestamp')).to eq(true)
        expect(header.key?('X-API-KEY')).to eq(true)
        expect(header.key?('X-Customer')).to eq(true)
        expect(header.key?('X-Signature')).to eq(true)
      end
    end
  end
end

describe DefaultCredentials do
  describe '.from_env' do
    context 'when all ok' do
      before(:each) do
        @orginal_api_key = ENV['NAVER_API_KEY']
        @orginal_api_secret = ENV['NAVER_API_SECRET']
        @orginal_client_id = ENV['NAVER_API_CLIENT_ID']

        ENV['NAVER_API_KEY'] = 'key'
        ENV['NAVER_API_SECRET'] = 'secret'
        ENV['NAVER_API_CLIENT_ID'] = '100993'
      end

      after(:each) do
        ENV['NAVER_API_KEY'] = @orginal_api_key
        ENV['NAVER_API_SECRET'] = @orginal_api_secret
        ENV['NAVER_API_CLIENT_ID'] = @orginal_client_id
      end

      it 'should return CustomerAcccountCredentials object with data from ENV' do
        credential = described_class.from_env
        expect(credential).to be_a_kind_of(CustomerAcccountCredentials)
        expect(credential.api_key).to eq('key')
        expect(credential.api_secret).to eq('secret')
        expect(credential.customer_id).to eq('100993')
      end
    end
  end
end
