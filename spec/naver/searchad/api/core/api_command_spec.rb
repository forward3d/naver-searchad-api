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
  end

  describe '.execute' do
    subject(:execute) { this.execute(client) }
  end

end
