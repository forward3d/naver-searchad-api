require 'spec_helper'

include Naver::Searchad::Api

describe Campaign::Service do
  subject(:this) { described_class.new }

  describe '#create_campaign' do
    subject(:create_campaign) { this.create_campaign(campaign, {}) }
    let(:campaign) {
      {
        'campaignTp' => 'WEB_SITE',
        'name' => 'test-04',
        'customerId' => '113131'
      }
    }

    context 'when all ok' do
      before(:each) do
        this.authorization = Auth.get_application_default
        stub_request(:post, 'https://api.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 200,
              body: "{\"nccCampaignId\":\"cmp-a001-01-000000000653279\",\"customerId\":113131,\"name\":\"test-04\",\"userLock\":false,\"campaignTp\":\"WEB_SITE\",\"deliveryMethod\":\"ACCELERATED\",\"trackingMode\":\"TRACKING_DISABLED\",\"delFlag\":false,\"regTm\":\"2017-07-17T17:23:43.000Z\",\"editTm\":\"2017-07-17T17:23:43.000Z\",\"usePeriod\":false,\"dailyBudget\":0,\"useDailyBudget\":false,\"status\":\"ELIGIBLE\",\"statusReason\":\"ELIGIBLE\",\"expectCost\":0,\"migType\":0}",
              headers: {'Content-Type' => 'application/json;charset=UTF-8'}
              )
      end

      it 'should return a created campaign object in hash with 200 ok' do
        campaign = create_campaign
        expect(campaign.ncc_campaign_id).to eq('cmp-a001-01-000000000653279')
        expect(campaign.customer_id).to eq(113131)
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

    context 'when no authorization is given' do
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              body: "{\"header\":\"X-API-KEY\",\"status\":403,\"title\":\"Missing Header\",\"detail\":\"HTTP header required: X-API-KEY\",\"type\":\"urn:naver:api:problem:missing-header\"}",
              headers: {'Content-Type' => 'application/json;charset=UTF-8'}
              )
      end

      it { expect { create_campaign }.to raise_error(RequestError) }
    end

    context 'when invalid api key is given' do
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              body: "{\"apikey\":\"#{ENV['NAVER_API_KEY']}\",\"status\":403,\"detail\":\"API-KEY '#{ENV['NAVER_API_KEY']}' is invalid.\",\"title\":\"Invalid API-KEY\",\"type\":\"urn:naver:api:problem:invalid-apikey\"}",
              headers: {'Content-Type' => 'application/json;charset=UTF-8'}
              )
      end

      it { expect { create_campaign }.to raise_error(RequestError) }
    end

    context 'when invalid api secret is given' do
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              body: "{\"signature\":\"74/lMuS4QVQs4o4B3BPellNUkxY5lr+FaHCERucig/w=\",\"status\":403,\"detail\":\"Signature '74/lMuS4QVQs4o4B3BPellNUkxY5lr+FaHCERucig/w=' is invalid.\",\"title\":\"Invalid Signature\",\"type\":\"urn:naver:api:problem:invalid-signature\"}",
              headers: {'Content-Type' => 'application/json;charset=UTF-8'}
              )
      end

      it { expect { create_campaign }.to raise_error(RequestError) }
    end

    context 'when invalid client id in authorization is given' do
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              body: "{\"apikey\":\"#{ENV['NAVER_API_KEY']}\",\"customerId\":#{ENV['NAVER_API_CLIENT_ID']},\"status\":403,\"detail\":\"Auth failed with api-key: #{ENV['NAVER_API_KEY']}, customer-id: #{ENV['NAVER_API_CLIENT_ID']}\",\"title\":\"Auth Failed\",\"type\":\"urn:naver:api:problem:auth-failed\"}",
              headers: {'Content-Type' => 'application/json;charset=UTF-8'}
              )
      end

      it { expect { create_campaign }.to raise_error(RequestError) }
    end

    context 'when creating a campaign with existing name' do
      before(:each) do
        campaign['name'] = 'existing-campaign'
        this.authorization = Auth.get_application_default
        stub_request(:post, 'https://api.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"existing-campaign\",\"customerId\":\"113131\"}").
            to_return(
              status: 400,
              body: "{\"code\":3506,\"status\":400,\"title\":\"A campaign with the same name already exists.\"}"
              )
      end

      it { expect { create_campaign }.to raise_error(CampaignAlreadyExistError) }
    end

    context 'when missing required attribute in request object' do
      let(:campaign) {
        {
          'campaignTp' => 'WEB_SITE',
          'name' => 'test-04',
        }
      }

      it { expect { create_campaign }.to raise_error(MissingRequiredAttributeError) }
    end
  end
end
