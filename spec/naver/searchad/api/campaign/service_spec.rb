require 'spec_helper'

describe Naver::Searchad::Api::Campaign::Service do
  subject(:this) { described_class.new }

  before(:each) do
    #ENV['NAVER_API_KEY'] = 'test_key'
    #ENV['NAVER_API_SECRET'] = 'test_secret'
    #ENV['NAVER_API_CLIENT_ID'] = '113131'

    ENV['NAVER_API_KEY'] = '0100000000f2e75122770874cb904034e7e27f5815c21af53a93f25b0f05f0ce97f263650c'
    ENV['NAVER_API_SECRET'] = 'AQAAAADy51Eidwh0y5BANOfif1gVwHjWG4MrXg6Mbh54YHY4MQ=='
    ENV['NAVER_API_CLIENT_ID'] = '1077530'
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
          #{}"campaignTp" => "WEB_SITE",
          "name" => "test-05",
          "customerId" => "1077530"
          #{}"customerId" => "113131"
        }
      }

      it 'should return a created campaign object in hash with 200 ok' do
        WebMock.disable!
        campaign = create_campaign
        expect(campaign.ncc_campaign_id).to eq('cmp-a001-01-000000000653279')
        expect(campaign.customer_id).to eq(1077530)
        expect(campaign.name).to eq('test-04')
        expect(campaign.user_lock).to eq(false)
        expect(campaign.campaign_tp).to eq('WEB_SITE')
        expect(campaign.delivery_method).to eq('ACCELERATED')
        expect(campaign.tracking_mode).to eq('TRACKING_DISABLED')
        expect(campaign.del_flag).to eq(false)
        expect(campaign.reg_tm).to eq('2017-07-17T17:23:43.000Z')
        expect(campaign.edit_tm).to eq('2017-07-17T17:23:43.000Z')
        expect(campaign.use_period).to eq(false)
        expect(campaign.daily_budget).to eq(0)
        expect(campaign.status).to eq('ELIGIBLE')
        expect(campaign.status_reason).to eq('ELIGIBLE')
        expect(campaign.expect_cost).to eq(0)
        expect(campaign.mig_type).to eq(0)
      end
    end

    context 'when creating a campaign with existing name' do
    end

    context 'when missing required attribute in request object' do
    end
  end
end
