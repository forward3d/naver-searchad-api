require 'spec_helper'

include Naver::Searchad::Api

describe Campaign::Service do
  subject(:this) { described_class.new }
  before(:each) do
    this.authorization = Auth.get_application_default
  end

  describe '#create_campaign' do
    subject(:create_campaign) { this.create_campaign(campaign) }
    let(:campaign) {
      {
        'campaignTp' => 'WEB_SITE',
        'name' => 'test-04',
        'customerId' => '113131'
      }
    }

    context 'when all ok' do
      before(:each) do
        stub_request(:post, 'https://api.searchad.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body:
              <<-JSON
{
  "nccCampaignId":"cmp-a001-01-000000000653279",
  "customerId":113131,
  "name":"test-04",
  "userLock":false,
  "campaignTp":"WEB_SITE",
  "deliveryMethod":"ACCELERATED",
  "trackingMode":"TRACKING_DISABLED",
  "delFlag":false,
  "regTm":"2017-07-17T17:23:43.000Z",
  "editTm":"2017-07-17T17:23:43.000Z",
  "usePeriod":false,
  "dailyBudget":0,
  "useDailyBudget":false,
  "status":"ELIGIBLE",
  "statusReason":"ELIGIBLE",
  "expectCost":0,
  "migType":0
}
JSON
              )
      end

      it 'should return a created campaign object in hash with 200 ok' do
        expect { |b| this.create_campaign(campaign, &b) }.
          to yield_with_args(OpenStruct.new(
            ncc_campaign_id: 'cmp-a001-01-000000000653279',
            customer_id: 113131,
            name: 'test-04',
            user_lock: false,
            campaign_tp: 'WEB_SITE',
            delivery_method: 'ACCELERATED',
            tracking_mode: 'TRACKING_DISABLED',
            del_flag: false,
            reg_tm: '2017-07-17T17:23:43.000Z',
            edit_tm: '2017-07-17T17:23:43.000Z',
            use_period: false,
            daily_budget: 0,
            use_daily_budget: false,
            status: 'ELIGIBLE',
            status_reason: 'ELIGIBLE',
            expect_cost: 0,
            mig_type: 0
          ), nil)
      end
    end

    context 'when no authorization is given' do
      before(:each) do
        this.authorization = nil
        stub_request(:post, 'https://api.searchad.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "header":"X-API-KEY",
  "status":403,
  "title":"Missing Header",
  "detail":"HTTP header required: X-API-KEY",
  "type":"urn:naver:api:problem:missing-header"
}
JSON
              )
      end

      let(:request) { create_campaign }

      it_behaves_like 'error in request'
    end

    context 'when invalid api key is given' do
      before(:each) do
        stub_request(:post, 'https://api.searchad.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "apikey":"#{ENV['NAVER_API_KEY']}",
  "status":403,
  "detail":"API-KEY '#{ENV['NAVER_API_KEY']}' is invalid.",
  "title":"Invalid API-KEY",
  "type":"urn:naver:api:problem:invalid-apikey"
}
JSON
              )
      end

      let(:request) { create_campaign }

      it_behaves_like 'error in request'
    end

    context 'when invalid api secret is given' do
      before(:each) do
        stub_request(:post, 'https://api.searchad.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "signature":"74/lMuS4QVQs4o4B3BPellNUkxY5lr+FaHCERucig/w=",
  "status":403,
  "detail":"Signature '74/lMuS4QVQs4o4B3BPellNUkxY5lr+FaHCERucig/w=' is invalid.",
  "title":"Invalid Signature",
  "type":"urn:naver:api:problem:invalid-signature"
}
JSON
              )
      end

      let(:request) { create_campaign }

      it_behaves_like 'error in request'
    end

    context 'when invalid client id in authorization is given' do
      before(:each) do
        stub_request(:post, 'https://api.searchad.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"test-04\",\"customerId\":\"113131\"}").
            to_return(
              status: 403,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "apikey":"#{ENV['NAVER_API_KEY']}",
  "customerId":#{ENV['NAVER_API_CLIENT_ID']},
  "status":403,
  "detail":"Auth failed with api-key: #{ENV['NAVER_API_KEY']}, customer-id: #{ENV['NAVER_API_CLIENT_ID']}",
  "title":"Auth Failed",
  "type":"urn:naver:api:problem:auth-failed"
}
JSON
              )
      end

      let(:request) { create_campaign }

      it_behaves_like 'error in request'
    end

    context 'when creating a campaign with existing name' do
      before(:each) do
        campaign['name'] = 'existing-campaign'
        stub_request(:post, 'https://api.searchad.naver.com/ncc/campaigns').
          with(body: "{\"campaignTp\":\"WEB_SITE\",\"name\":\"existing-campaign\",\"customerId\":\"113131\"}").
            to_return(
              status: 400,
              body: <<-JSON
{
  "code":3506,
  "status":400,
  "title":"A campaign with the same name already exists."
}
JSON
              )
      end

      it { expect { create_campaign }.to raise_error(DuplicatedCampaignNameError) }
    end

    context 'when missing required attributes in request object' do
      let(:campaign) {
        {
          'campaignTp' => 'WEB_SITE',
          'name' => 'test-04',
        }
      }

      it { expect { create_campaign }.to raise_error(MissingRequiredAttributeError) }
    end
  end

  describe '#list_campaigns_by_ids' do
    context 'when requesting multiple ids' do
      before(:each) do
        stub_request(:get, 'https://api.searchad.naver.com/ncc/campaigns/?ids=cmp-a001-01-000000000652963,cmp-a001-01-000000000653273').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "customerId":113131,
    "name":"test-00",
    "userLock":false,
    "campaignTp":"WEB_SITE",
    "deliveryMethod":"ACCELERATED",
    "trackingMode":"TRACKING_DISABLED",
    "delFlag":false,
    "regTm":"2017-07-17T09:54:34.000Z",
    "editTm":"2017-07-17T09:54:34.000Z",
    "usePeriod":false,
    "dailyBudget":0,
    "useDailyBudget":false,
    "status":"ELIGIBLE",
    "statusReason":"ELIGIBLE",
    "expectCost":0,
    "migType":0
  },
  {
    "nccCampaignId":"cmp-a001-01-000000000653273",
    "customerId":113131,
    "name":"test-01",
    "userLock":false,
    "campaignTp":"WEB_SITE",
    "deliveryMethod":"ACCELERATED",
    "trackingMode":"TRACKING_DISABLED",
    "delFlag":false,
    "regTm":"2017-07-17T17:13:51.000Z",
    "editTm":"2017-07-17T17:13:51.000Z",
    "usePeriod":false,
    "dailyBudget":0,
    "useDailyBudget":false,
    "status":"ELIGIBLE",
    "statusReason":"ELIGIBLE",
    "expectCost":0,
    "migType":0
  }
]
JSON
            )
      end
      let(:campaign_ids) { ['cmp-a001-01-000000000652963', 'cmp-a001-01-000000000653273'] }

      it 'should return an array of relevant campaign items' do
        expect { |b| this.list_campaigns_by_ids(campaign_ids, &b) }.
          to yield_with_args([
            OpenStruct.new(
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              customer_id: 113131,
              name: 'test-00',
              user_lock: false,
              campaign_tp: 'WEB_SITE',
              delivery_method: 'ACCELERATED',
              tracking_mode: 'TRACKING_DISABLED',
              del_flag: false,
              reg_tm: '2017-07-17T09:54:34.000Z',
              edit_tm: '2017-07-17T09:54:34.000Z',
              use_period: false,
              daily_budget: 0,
              use_daily_budget: false,
              status: 'ELIGIBLE',
              status_reason: 'ELIGIBLE',
              expect_cost: 0,
              mig_type: 0
            ),
            OpenStruct.new(
              ncc_campaign_id: 'cmp-a001-01-000000000653273',
              customer_id: 113131,
              name: 'test-01',
              user_lock: false,
              campaign_tp: 'WEB_SITE',
              delivery_method: 'ACCELERATED',
              tracking_mode: 'TRACKING_DISABLED',
              del_flag: false,
              reg_tm: '2017-07-17T17:13:51.000Z',
              edit_tm: '2017-07-17T17:13:51.000Z',
              use_period: false,
              daily_budget: 0,
              use_daily_budget: false,
              status: 'ELIGIBLE',
              status_reason: 'ELIGIBLE',
              expect_cost: 0,
              mig_type: 0
            )
          ], nil)
      end
    end

    context 'when requesting none existing id' do
      before(:each) do
        stub_request(:get, 'https://api.searchad.naver.com/ncc/campaigns/?ids=none-existing').
          to_return(
            status: 404,
            body: <<-JSON
{
  "code":1018,
  "status":404,
  "title":"No permission to access the resource."
}
JSON
            )
      end
      let(:campaign_ids) { ['none-existing'] }
      let(:request) { this.list_campaigns_by_ids(campaign_ids) }

      it_behaves_like 'not enough permission request'
    end
  end

  describe '#list_campaigns' do
    context 'when requesting camapgins' do
      before(:each) do
        stub_request(:get, 'https://api.searchad.naver.com/ncc/campaigns').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "customerId":113131,
    "name":"test-00",
    "userLock":false,
    "campaignTp":"WEB_SITE",
    "deliveryMethod":"ACCELERATED",
    "trackingMode":"TRACKING_DISABLED",
    "delFlag":false,
    "regTm":"2017-07-17T09:54:34.000Z",
    "editTm":"2017-07-17T09:54:34.000Z",
    "usePeriod":false,
    "dailyBudget":0,
    "useDailyBudget":false,
    "status":"ELIGIBLE",
    "statusReason":"ELIGIBLE",
    "expectCost":0,
    "migType":0
  },
  {
    "nccCampaignId":"cmp-a001-01-000000000653273",
    "customerId":113131,
    "name":"test-01",
    "userLock":false,
    "campaignTp":"WEB_SITE",
    "deliveryMethod":"ACCELERATED",
    "trackingMode":"TRACKING_DISABLED",
    "delFlag":false,
    "regTm":"2017-07-17T17:13:51.000Z",
    "editTm":"2017-07-17T17:13:51.000Z",
    "usePeriod":false,
    "dailyBudget":0,
    "useDailyBudget":false,
    "status":"ELIGIBLE",
    "statusReason":"ELIGIBLE",
    "expectCost":0,
    "migType":0
  }
]
JSON
            )
      end
      let(:campaign_ids) { ['cmp-a001-01-000000000652963', 'cmp-a001-01-000000000653273'] }

      it 'should return an array of relevant campaign items' do
        expect { |b| this.list_campaigns(&b) }.
          to yield_with_args([
            OpenStruct.new(
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              customer_id: 113131,
              name: 'test-00',
              user_lock: false,
              campaign_tp: 'WEB_SITE',
              delivery_method: 'ACCELERATED',
              tracking_mode: 'TRACKING_DISABLED',
              del_flag: false,
              reg_tm: '2017-07-17T09:54:34.000Z',
              edit_tm: '2017-07-17T09:54:34.000Z',
              use_period: false,
              daily_budget: 0,
              use_daily_budget: false,
              status: 'ELIGIBLE',
              status_reason: 'ELIGIBLE',
              expect_cost: 0,
              mig_type: 0
            ),
            OpenStruct.new(
              ncc_campaign_id: 'cmp-a001-01-000000000653273',
              customer_id: 113131,
              name: 'test-01',
              user_lock: false,
              campaign_tp: 'WEB_SITE',
              delivery_method: 'ACCELERATED',
              tracking_mode: 'TRACKING_DISABLED',
              del_flag: false,
              reg_tm: '2017-07-17T17:13:51.000Z',
              edit_tm: '2017-07-17T17:13:51.000Z',
              use_period: false,
              daily_budget: 0,
              use_daily_budget: false,
              status: 'ELIGIBLE',
              status_reason: 'ELIGIBLE',
              expect_cost: 0,
              mig_type: 0
            )
          ], nil)
      end
    end
  end

  describe '#get_campaign' do
    context 'when all ok' do
      before(:each) do
        stub_request(:get, 'https://api.searchad.naver.com/ncc/campaigns/cmp-a001-01-000000000652963').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "customerId":113131,
  "name":"test-00",
  "userLock":false,
  "campaignTp":"WEB_SITE",
  "deliveryMethod":"ACCELERATED",
  "trackingMode":"TRACKING_DISABLED",
  "delFlag":false,
  "regTm":"2017-07-17T09:54:34.000Z",
  "editTm":"2017-07-17T09:54:34.000Z",
  "usePeriod":false,
  "dailyBudget":0,
  "useDailyBudget":false,
  "status":"ELIGIBLE",
  "statusReason":"ELIGIBLE",
  "expectCost":0,
  "migType":0
}
JSON
          )
      end

      let(:campaign_id) { 'cmp-a001-01-000000000652963' }

      it 'should return relevant campaign item' do
        expect { |b| this.get_campaign(campaign_id, &b) }.
          to yield_with_args(OpenStruct.new(
            ncc_campaign_id: 'cmp-a001-01-000000000652963',
            customer_id: 113131,
            name: 'test-00',
            user_lock: false,
            campaign_tp: 'WEB_SITE',
            delivery_method: 'ACCELERATED',
            tracking_mode: 'TRACKING_DISABLED',
            del_flag: false,
            reg_tm: '2017-07-17T09:54:34.000Z',
            edit_tm: '2017-07-17T09:54:34.000Z',
            use_period: false,
            daily_budget: 0,
            use_daily_budget: false,
            status: 'ELIGIBLE',
            status_reason: 'ELIGIBLE',
            expect_cost: 0,
            mig_type: 0
          ), nil)
      end
    end

    context 'when requesting none-existing campaign' do
      before(:each) do
        stub_request(:get, 'https://api.searchad.naver.com/ncc/campaigns/none-existing').
          to_return(
            status: 404,
            body: <<-JSON
{
  "code":1018,
  "status":404,
  "title":"No permission to access the resource."
}
JSON
            )
      end
      let(:campaign_id) { 'none-existing' }
      let(:request) { this.get_campaign(campaign_id) }

      it_behaves_like 'not enough permission request'
    end
  end

  describe '#update_campaign' do
    context 'when all ok' do
      context 'with userLock given' do
        let(:campaign) do
          {
            'nccCampaignId' => 'cmp-a001-01-000000000652963',
            'userLock' => true
          }
        end

        before(:each) do
          stub_request(:put, 'https://api.searchad.naver.com/ncc/campaigns/cmp-a001-01-000000000652963?fields=userLock').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "userLock":true
}
JSON
          )
        end

        it 'should update user_lock' do
          result = this.update_campaign(campaign, field: 'userLock')
          expect(result.user_lock).to eq(true)
        end
      end

      context 'with budget given' do
        let(:campaign) do
          {
            'nccCampaignId' => 'cmp-a001-01-000000000652963',
            'dailyBudget' => 100,
            'useDailyBudget' => true
          }
        end

        before(:each) do
          stub_request(:put, 'https://api.searchad.naver.com/ncc/campaigns/cmp-a001-01-000000000652963?fields=budget').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "dailyBudget":100,
  "useDailyBudget":true
}
JSON
          )
        end

        it 'should update daily_budget and use_daily_budget' do
          result = this.update_campaign(campaign, field: 'budget')
          expect(result.daily_budget).to eq(100)
          expect(result.use_daily_budget).to eq(true)
        end
      end

      context 'with period given' do
        let(:campaign) do
          {
            'nccCampaignId' => 'cmp-a001-01-000000000652963',
            'periodStartDt' => '2017-08-17T17:13:51.000Z',
            'periodEndDt' => '2017-08-30T17:13:51.000Z',
            'usePeriod' => true
          }
        end

        before(:each) do
          stub_request(:put, 'https://api.searchad.naver.com/ncc/campaigns/cmp-a001-01-000000000652963?fields=period').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "usePeriod":true,
  "periodStartDt":"2017-08-17T15:00:00.000Z",
  "periodEndDt":"2017-08-30T15:00:00.000Z"
}
JSON
          )
        end

        it 'should update use_period, period_start_dt and period_end_dt fields and return updated object' do
          result = this.update_campaign(campaign, field: 'period')
          expect(result.use_period).to eq(true)
          expect(result.period_start_dt).to eq('2017-08-17T15:00:00.000Z')
          expect(result.period_end_dt).to eq('2017-08-30T15:00:00.000Z')
        end
      end

      context 'without specific field' do
        let(:campaign) do
          {
            'nccCampaignId' => 'cmp-a001-01-000000000652963',
            'name' => 'test-updated',
            'campaignTp' => 'WEB_SITE',
            'customerId' => 1077530,
            'userLock' => false,
            'deliveryMethod' => 'ACCELERATED',
            "trackingMode" => "TRACKING_DISABLED",
            'periodStartDt' => '2017-08-17T17:13:51.000Z',
            'periodEndDt' => '2017-08-30T17:13:51.000Z',
            'usePeriod' => true,
            'dailyBudget' => 100,
            'useDailyBudget' => true
          }
        end
        before(:each) do
          stub_request(:put, 'https://api.searchad.naver.com/ncc/campaigns/cmp-a001-01-000000000652963').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "customerId":1077530,
  "name":"test-updated",
  "userLock":false,
  "campaignTp":"WEB_SITE",
  "deliveryMethod":"ACCELERATED",
  "trackingMode":"TRACKING_DISABLED",
  "delFlag":false,
  "regTm":"2017-07-17T09:54:34.000Z",
  "editTm":"2017-07-19T16:14:36.000Z",
  "usePeriod":true,
  "periodStartDt":"2017-08-17T15:00:00.000Z",
  "periodEndDt":"2017-08-30T15:00:00.000Z",
  "dailyBudget":100,
  "useDailyBudget":true,
  "status":"PAUSED",
  "statusReason":"CAMPAIGN_PENDING",
  "expectCost":0,
  "migType":0
}
JSON
          )
        end

        it 'should update user_lock field and return updated object' do
          expect { |b| this.update_campaign(campaign, &b) }.
            to yield_with_args(OpenStruct.new(
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              customer_id: 1077530,
              name: "test-updated",
              user_lock: false,
              campaign_tp: "WEB_SITE",
              delivery_method: "ACCELERATED",
              tracking_mode: "TRACKING_DISABLED",
              del_flag: false,
              reg_tm: "2017-07-17T09:54:34.000Z",
              edit_tm: "2017-07-19T16:14:36.000Z",
              use_period: true,
              period_start_dt: "2017-08-17T15:00:00.000Z",
              period_end_dt: "2017-08-30T15:00:00.000Z",
              daily_budget: 100,
              use_daily_budget: true,
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0
              ), nil)
        end
      end
    end

    context 'when given campaign id does not exist' do
      let(:field) { 'userLock' }
      let(:campaign) do
        {
          'nccCampaignId' => 'none-existing',
          'userLock' => true
        }
      end

      before(:each) do
        stub_request(:put, 'https://api.searchad.naver.com/ncc/campaigns/none-existing?fields=userLock').
          to_return(
            status: 404,
            body: <<-JSON
{
  "code":1018,
  "status":404,
  "title":"No permission to access the resource."
}
JSON
            )
      end

      let(:request) { this.update_campaign(campaign, field: field) }

      it_behaves_like 'not enough permission request'
    end

    context 'when invalid field is given' do
      let(:field) { 'deliveryMethod' }
      let(:campaign) do
        {
          'nccCampaignId' => 'cmp-a001-01-000000000652963',
          'deliveryMethod' => 'ACCELERATED'
        }
      end

      before(:each) do
        stub_request(:put, 'https://api.searchad.naver.com/ncc/campaigns/cmp-a001-01-000000000652963?fields=deliveryMethod').
          to_return(
            status: 400,
            body: <<-JSON
{
  "code":1002,
  "status":400,
  "title":"Invalid request"
}
JSON
            )
      end

      let(:request) { this.update_campaign(campaign, field: field) }

      it_behaves_like 'invalid request'
    end
    #
  end

  describe '#delete_campaign' do
    context 'when all ok' do
      let(:campaign_id) { 'cmp-a001-01-000000000653279' }

      before(:each) do
        stub_request(:delete, 'https://api.searchad.naver.com/ncc/campaigns/cmp-a001-01-000000000653279').
          to_return(status: 204)
      end

      it 'should delete the given campaign and return none' do
        expect { |b| this.delete_campaign(campaign_id, &b) }.
          to yield_with_args('', nil)
      end
    end

    context 'when given campaign id does not exist' do
      let(:campaign_id) { 'none-existing' }

      before(:each) do
        stub_request(:delete, 'https://api.searchad.naver.com/ncc/campaigns/none-existing').
          to_return(
            status: 404,
            body: <<-JSON
{
  "code":1018,
  "status":404,
  "title":"No permission to access the resource."
}
JSON
            )
      end

      let(:request) { this.delete_campaign(campaign_id) }

      it_behaves_like 'not enough permission request'
    end
  end
end
