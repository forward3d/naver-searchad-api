require 'spec_helper'

describe Naver::Searchad::Api::Campaign::Service do
  subject(:this) { described_class.new }

  describe '#create_campaign' do
    subject(:create_campaign) { this.create_campaign(campaign, {}) }

    context 'when all ok' do
      let(:campaign) { {} }
      it '' do
        WebMock.disable!
        this.authorization = Naver::Searchad::Api::Auth.get_application_default
        create_campaign
      end
    end

    context 'when missing required attribute in request object' do
    end
  end
end
