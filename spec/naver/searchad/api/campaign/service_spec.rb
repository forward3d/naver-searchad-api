require 'spec_helper'

describe Naver::Searchad::Api::Campaign::Service do
  subject(:this) { described_class.new }

  before(:each) do
    ENV['NAVER_API_KEY'] = 'test_key'
    ENV['NAVER_API_SECRET'] = 'test_secret'
    ENV['NAVER_API_CLIENT_ID'] = '113131'
  end

  after(:each) do
    ENV['NAVER_API_KEY'] = ''
    ENV['NAVER_API_SECRET'] = ''
    ENV['NAVER_API_CLIENT_ID'] = ''
  end

  describe '#create_campaign' do
    subject(:create_campaign) { this.create_campaign(campaign, {}) }

    context 'when all ok' do
      before(:each) do
        this.authorization = Naver::Searchad::Api::Auth.get_application_default
        stub_request(:post, 'https://api.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 200,
              body: "{\"nccCampaignId\":\"cmp-a001-01-000000000653279\",\"customerId\":1077530,\"name\":\"test-04\",\"userLock\":false,\"campaignTp\":\"WEB_SITE\",\"deliveryMethod\":\"ACCELERATED\",\"trackingMode\":\"TRACKING_DISABLED\",\"delFlag\":false,\"regTm\":\"2017-07-17T17:23:43.000Z\",\"editTm\":\"2017-07-17T17:23:43.000Z\",\"usePeriod\":false,\"dailyBudget\":0,\"useDailyBudget\":false,\"status\":\"ELIGIBLE\",\"statusReason\":\"ELIGIBLE\",\"expectCost\":0,\"migType\":0}",
              headers: {'Content-Type' => 'application/json;charset=UTF-8'}
              )
      end
      let(:campaign) {
        {
          "campaignTp" => "WEB_SITE",
          "name" => "test-04",
          "customerId" => "113131"
        }
      }

      it 'should return a created campaign object in hash with 200 ok' do
        campaign = create_campaign
        expect(campaign).to include('nccCampaignId')
        expect(campaign).to include('customerId')
        expect(campaign).to include('name')
        expect(campaign).to include('userLock')
        expect(campaign).to include('campaignTp')
        expect(campaign).to include('deliveryMethod')
        expect(campaign).to include('trackingMode')
        expect(campaign).to include('delFlag')
        expect(campaign).to include('regTm')
        expect(campaign).to include('editTm')
        expect(campaign).to include('usePeriod')
        expect(campaign).to include('dailyBudget')
        expect(campaign).to include('status')
        expect(campaign).to include('statusReason')
        expect(campaign).to include('expectCost')
        expect(campaign).to include('migType')
      end
    end

    context 'when missing required attribute in request object' do
    end
  end
end
