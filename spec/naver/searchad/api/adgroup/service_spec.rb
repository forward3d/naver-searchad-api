require 'spec_helper'

include Naver::Searchad::Api

describe Adgroup::Service do
  subject(:this) { described_class.new }
  before(:each) do
    this.authorization = Auth.get_application_default
  end

  describe '#list_adgroups_by_ids' do
    context 'when requesting more than one' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups?ids=grp-a001-01-000000003853231,grp-a001-01-000000003853237').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccAdgroupId":"grp-a001-01-000000003853231",
    "customerId":1077530,
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "mobileChannelId":"bsn-a001-00-000000000043392",
    "pcChannelId":"bsn-a001-00-000000000043392",
    "bidAmt":70,
    "name":"test-ad-group-00",
    "userLock":false,
    "useDailyBudget":false,
    "useKeywordPlus":false,
    "keywordPlusWeight":100,
    "contentsNetworkBidAmt":70,
    "useCntsNetworkBidAmt":false,
    "mobileNetworkBidWeight":100,
    "pcNetworkBidWeight":100,
    "dailyBudget":0,
    "budgetLock":false,
    "delFlag":false,
    "regTm":"2017-07-18T16:31:02.000Z",
    "editTm":"2017-07-18T16:31:02.000Z",
    "targetSummary":{
      "week":"all",
      "pcMobile":"all",
      "media":"all",
      "time":"all",
      "region":"all"
    },
    "pcChannelKey":"http://www.mymemodel.com",
    "mobileChannelKey":"http://www.mymemodel.com",
    "status":"PAUSED",
    "statusReason":"CAMPAIGN_PENDING",
    "expectCost":0,
    "migType":0,
    "adgroupAttrJson":{
      "campaignTp":1
    }
  },
  {
    "nccAdgroupId":"grp-a001-01-000000003853237",
    "customerId":1077530,
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "mobileChannelId":"bsn-a001-00-000000000043392",
    "pcChannelId":"bsn-a001-00-000000000043392",
    "bidAmt":70,
    "name":"test-ad-group-01",
    "userLock":false,
    "useDailyBudget":false,
    "useKeywordPlus":false,
    "keywordPlusWeight":100,
    "contentsNetworkBidAmt":70,
    "useCntsNetworkBidAmt":false,
    "mobileNetworkBidWeight":100,
    "pcNetworkBidWeight":100,
    "dailyBudget":0,
    "budgetLock":false,
    "delFlag":false,
    "regTm":"2017-07-18T16:37:59.000Z",
    "editTm":"2017-07-18T16:37:59.000Z",
    "targetSummary":{
      "week":"all",
      "pcMobile":"all",
      "media":"all",
      "time":"all",
      "region":"all"
    },
    "pcChannelKey":"http://www.mymemodel.com",
    "mobileChannelKey":"http://www.mymemodel.com",
    "status":"PAUSED",
    "statusReason":"CAMPAIGN_PENDING",
    "expectCost":0,
    "migType":0,
    "adgroupAttrJson":{
      "campaignTp":1
    }
  }
]
JSON
        )
      end
      let(:adgroup_ids) { %w[grp-a001-01-000000003853231 grp-a001-01-000000003853237] }

      it 'should return an array of relevant adgroup items' do
        expect { |b| this.list_adgroups_by_ids(adgroup_ids, &b) }.
          to yield_with_args([
             OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003853231",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 70,
              name: "test-ad-group-00",
              user_lock: false,
              use_daily_budget: false,
              use_keyword_plus: false,
              keyword_plus_weight: 100,
              contents_network_bid_amt: 70,
              use_cnts_network_bid_amt: false,
              mobile_network_bid_weight: 100,
              pc_network_bid_weight: 100,
              daily_budget: 0,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-18T16:31:02.000Z",
              edit_tm: "2017-07-18T16:31:02.000Z",
              target_summary: {
                "week"=>"all",
                "pc_mobile"=>"all",
                "media"=>"all",
                "time"=>"all",
                "region"=>"all"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
            ),
            OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003853237",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 70,
              name: "test-ad-group-01",
              user_lock: false,
              use_daily_budget: false,
              use_keyword_plus: false,
              keyword_plus_weight: 100,
              contents_network_bid_amt: 70,
              use_cnts_network_bid_amt: false,
              mobile_network_bid_weight: 100,
              pc_network_bid_weight: 100,
              daily_budget: 0,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-18T16:37:59.000Z",
              edit_tm: "2017-07-18T16:37:59.000Z",
              target_summary: {
                "week"=>"all",
                "pc_mobile"=>"all",
                "media"=>"all",
                "time"=>"all",
                "region"=>"all"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
            )
            ], nil)
      end
    end

    context 'when requesting none-existing one' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups?ids=none-existing').
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
      let(:adgroup_ids) { ['none-existing'] }

      it { expect{ this.list_adgroups_by_ids(adgroup_ids) }.to raise_error(NotEnoughPermissionError) }
    end
  end

  describe '#list_adgroups_by_campaign_id' do
    context 'when all ok' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups?nccCampaignId=cmp-a001-01-000000000652963').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccAdgroupId":"grp-a001-01-000000003853231",
    "customerId":1077530,
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "mobileChannelId":"bsn-a001-00-000000000043392",
    "pcChannelId":"bsn-a001-00-000000000043392",
    "bidAmt":70,
    "name":"test-ad-group-00",
    "userLock":false,
    "useDailyBudget":false,
    "useKeywordPlus":false,
    "keywordPlusWeight":100,
    "contentsNetworkBidAmt":70,
    "useCntsNetworkBidAmt":false,
    "mobileNetworkBidWeight":100,
    "pcNetworkBidWeight":100,
    "dailyBudget":0,
    "budgetLock":false,
    "delFlag":false,
    "regTm":"2017-07-18T16:31:02.000Z",
    "editTm":"2017-07-18T16:31:02.000Z",
    "targetSummary":{
      "week":"all",
      "pcMobile":"all",
      "media":"all",
      "time":"all",
      "region":"all"
    },
    "pcChannelKey":"http://www.mymemodel.com",
    "mobileChannelKey":"http://www.mymemodel.com",
    "status":"PAUSED",
    "statusReason":"CAMPAIGN_PENDING",
    "expectCost":0,
    "migType":0,
    "adgroupAttrJson":{
      "campaignTp":1
    }
  },
  {
    "nccAdgroupId":"grp-a001-01-000000003853237",
    "customerId":1077530,
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "mobileChannelId":"bsn-a001-00-000000000043392",
    "pcChannelId":"bsn-a001-00-000000000043392",
    "bidAmt":70,
    "name":"test-ad-group-01",
    "userLock":false,
    "useDailyBudget":false,
    "useKeywordPlus":false,
    "keywordPlusWeight":100,
    "contentsNetworkBidAmt":70,
    "useCntsNetworkBidAmt":false,
    "mobileNetworkBidWeight":100,
    "pcNetworkBidWeight":100,
    "dailyBudget":0,
    "budgetLock":false,
    "delFlag":false,
    "regTm":"2017-07-18T16:37:59.000Z",
    "editTm":"2017-07-18T16:37:59.000Z",
    "targetSummary":{
      "week":"all",
      "pcMobile":"all",
      "media":"all",
      "time":"all",
      "region":"all"
    },
    "pcChannelKey":"http://www.mymemodel.com",
    "mobileChannelKey":"http://www.mymemodel.com",
    "status":"PAUSED",
    "statusReason":"CAMPAIGN_PENDING",
    "expectCost":0,
    "migType":0,
    "adgroupAttrJson":{
      "campaignTp":1
    }
  }
]
JSON
        )
      end
      let(:campaign_id) { 'cmp-a001-01-000000000652963' }

      it 'should return an array of relevant adgroup items' do
        expect { |b| this.list_adgroups_by_campaign_id(campaign_id, &b) }.
          to yield_with_args([
             OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003853231",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 70,
              name: "test-ad-group-00",
              user_lock: false,
              use_daily_budget: false,
              use_keyword_plus: false,
              keyword_plus_weight: 100,
              contents_network_bid_amt: 70,
              use_cnts_network_bid_amt: false,
              mobile_network_bid_weight: 100,
              pc_network_bid_weight: 100,
              daily_budget: 0,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-18T16:31:02.000Z",
              edit_tm: "2017-07-18T16:31:02.000Z",
              target_summary: {
                "week"=>"all",
                "pc_mobile"=>"all",
                "media"=>"all",
                "time"=>"all",
                "region"=>"all"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
            ),
            OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003853237",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 70,
              name: "test-ad-group-01",
              user_lock: false,
              use_daily_budget: false,
              use_keyword_plus: false,
              keyword_plus_weight: 100,
              contents_network_bid_amt: 70,
              use_cnts_network_bid_amt: false,
              mobile_network_bid_weight: 100,
              pc_network_bid_weight: 100,
              daily_budget: 0,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-18T16:37:59.000Z",
              edit_tm: "2017-07-18T16:37:59.000Z",
              target_summary: {
                "week"=>"all",
                "pc_mobile"=>"all",
                "media"=>"all",
                "time"=>"all",
                "region"=>"all"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
            )
            ], nil)
      end
    end

    context 'when requesting none existing id' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups?nccCampaignId=none-existing').
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

      it { expect{ this.list_adgroups_by_campaign_id(campaign_ids) }.to raise_error(NotEnoughPermissionError) }
    end
  end

  describe '#list_adgroups_by_label_id' do
    context 'when all ok' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups?nccLabelId=working_label_id').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccAdgroupId":"grp-a001-01-000000003853231",
    "customerId":1077530,
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "mobileChannelId":"bsn-a001-00-000000000043392",
    "pcChannelId":"bsn-a001-00-000000000043392",
    "bidAmt":70,
    "name":"test-ad-group-00",
    "userLock":false,
    "useDailyBudget":false,
    "useKeywordPlus":false,
    "keywordPlusWeight":100,
    "contentsNetworkBidAmt":70,
    "useCntsNetworkBidAmt":false,
    "mobileNetworkBidWeight":100,
    "pcNetworkBidWeight":100,
    "dailyBudget":0,
    "budgetLock":false,
    "delFlag":false,
    "regTm":"2017-07-18T16:31:02.000Z",
    "editTm":"2017-07-18T16:31:02.000Z",
    "targetSummary":{
      "week":"all",
      "pcMobile":"all",
      "media":"all",
      "time":"all",
      "region":"all"
    },
    "pcChannelKey":"http://www.mymemodel.com",
    "mobileChannelKey":"http://www.mymemodel.com",
    "status":"PAUSED",
    "statusReason":"CAMPAIGN_PENDING",
    "expectCost":0,
    "migType":0,
    "adgroupAttrJson":{
      "campaignTp":1
    }
  },
  {
    "nccAdgroupId":"grp-a001-01-000000003853237",
    "customerId":1077530,
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "mobileChannelId":"bsn-a001-00-000000000043392",
    "pcChannelId":"bsn-a001-00-000000000043392",
    "bidAmt":70,
    "name":"test-ad-group-01",
    "userLock":false,
    "useDailyBudget":false,
    "useKeywordPlus":false,
    "keywordPlusWeight":100,
    "contentsNetworkBidAmt":70,
    "useCntsNetworkBidAmt":false,
    "mobileNetworkBidWeight":100,
    "pcNetworkBidWeight":100,
    "dailyBudget":0,
    "budgetLock":false,
    "delFlag":false,
    "regTm":"2017-07-18T16:37:59.000Z",
    "editTm":"2017-07-18T16:37:59.000Z",
    "targetSummary":{
      "week":"all",
      "pcMobile":"all",
      "media":"all",
      "time":"all",
      "region":"all"
    },
    "pcChannelKey":"http://www.mymemodel.com",
    "mobileChannelKey":"http://www.mymemodel.com",
    "status":"PAUSED",
    "statusReason":"CAMPAIGN_PENDING",
    "expectCost":0,
    "migType":0,
    "adgroupAttrJson":{
      "campaignTp":1
    }
  }
]
JSON
        )
      end
      let(:label_id) { 'working_label_id' }

      it 'should return an array of relevant adgroup items' do
        expect { |b| this.list_adgroups_by_label_id(label_id, &b) }.
          to yield_with_args([
             OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003853231",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 70,
              name: "test-ad-group-00",
              user_lock: false,
              use_daily_budget: false,
              use_keyword_plus: false,
              keyword_plus_weight: 100,
              contents_network_bid_amt: 70,
              use_cnts_network_bid_amt: false,
              mobile_network_bid_weight: 100,
              pc_network_bid_weight: 100,
              daily_budget: 0,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-18T16:31:02.000Z",
              edit_tm: "2017-07-18T16:31:02.000Z",
              target_summary: {
                "week"=>"all",
                "pc_mobile"=>"all",
                "media"=>"all",
                "time"=>"all",
                "region"=>"all"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
            ),
            OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003853237",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 70,
              name: "test-ad-group-01",
              user_lock: false,
              use_daily_budget: false,
              use_keyword_plus: false,
              keyword_plus_weight: 100,
              contents_network_bid_amt: 70,
              use_cnts_network_bid_amt: false,
              mobile_network_bid_weight: 100,
              pc_network_bid_weight: 100,
              daily_budget: 0,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-18T16:37:59.000Z",
              edit_tm: "2017-07-18T16:37:59.000Z",
              target_summary: {
                "week"=>"all",
                "pc_mobile"=>"all",
                "media"=>"all",
                "time"=>"all",
                "region"=>"all"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
            )
            ], nil)
      end
    end

    context 'when requesting none existing id' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups?nccLabelId=none-existing').
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
      let(:label_id) { 'none-existing' }

      it { expect{ this.list_adgroups_by_label_id(label_id) }.to raise_error(NotEnoughPermissionError) }
    end
  end

  describe '#get_adgroup' do
    context 'when all ok' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003853231').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003853231",
  "customerId":1077530,
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "mobileChannelId":"bsn-a001-00-000000000043392",
  "pcChannelId":"bsn-a001-00-000000000043392",
  "bidAmt":70,
  "name":"test-ad-group-00",
  "userLock":false,
  "useDailyBudget":false,
  "useKeywordPlus":false,
  "keywordPlusWeight":100,
  "contentsNetworkBidAmt":70,
  "useCntsNetworkBidAmt":false,
  "mobileNetworkBidWeight":100,
  "pcNetworkBidWeight":100,
  "dailyBudget":0,
  "budgetLock":false,
  "delFlag":false,
  "regTm":"2017-07-18T16:31:02.000Z",
  "editTm":"2017-07-18T16:31:02.000Z",
  "targets":[
    {
      "nccTargetId":"tgt-a001-01-000000031612670",
      "ownerId":"grp-a001-01-000000003853231",
      "targetTp":"TIME_WEEKLY_TARGET",
      "target":null,
      "delFlag":false,
      "regTm":"2017-07-18T16:31:02.000Z",
      "editTm":"2017-07-18T16:31:02.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031612671",
      "ownerId":"grp-a001-01-000000003853231",
      "targetTp":"REGIONAL_TARGET",
      "target":null,
      "delFlag":false,
      "regTm":"2017-07-18T16:31:02.000Z",
      "editTm":"2017-07-18T16:31:02.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031612672",
      "ownerId":"grp-a001-01-000000003853231",
      "targetTp":"MEDIA_TARGET",
      "target":{
        "type":1,
        "search":[],
        "contents":[],
        "white":{
          "media":null,
          "mediaGroup":null
        },
        "black":{
          "media":null,
          "mediaGroup":null
        }
      },
      "delFlag":false,
      "regTm":"2017-07-18T16:31:02.000Z",
      "editTm":"2017-07-18T16:31:02.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031612673",
      "ownerId":"grp-a001-01-000000003853231",
      "targetTp":"PC_MOBILE_TARGET",
      "target":{
        "pc":true,
        "mobile":true
      },
      "delFlag":false,
      "regTm":"2017-07-18T16:31:02.000Z",
      "editTm":"2017-07-18T16:31:02.000Z"
    }
  ],
  "targetSummary":{
    "week":"all",
    "pcMobile":"all",
    "media":"all",
    "time":"all",
    "region":"all"
  },
  "pcChannelKey":"http://www.mymemodel.com",
  "mobileChannelKey":"http://www.mymemodel.com",
  "status":"PAUSED",
  "statusReason":"CAMPAIGN_PENDING",
  "expectCost":0,
  "migType":0,
  "adgroupAttrJson":{"campaignTp":1}
}
JSON
        )
      end
      let(:adgroup_id) { 'grp-a001-01-000000003853231' }

      it 'should return relevant adgroup item' do
        expect { |b| this.get_adgroup(adgroup_id, &b) }.
          to yield_with_args(OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003853231",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 70,
              name: "test-ad-group-00",
              user_lock: false,
              use_daily_budget: false,
              use_keyword_plus: false,
              keyword_plus_weight: 100,
              contents_network_bid_amt: 70,
              use_cnts_network_bid_amt: false,
              mobile_network_bid_weight: 100,
              pc_network_bid_weight: 100,
              daily_budget: 0,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-18T16:31:02.000Z",
              edit_tm: "2017-07-18T16:31:02.000Z",
              targets: [
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031612670",
                  "owner_id"=>"grp-a001-01-000000003853231",
                  "target_tp"=>"TIME_WEEKLY_TARGET",
                  "target"=>nil,
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-18T16:31:02.000Z",
                  "edit_tm"=>"2017-07-18T16:31:02.000Z"
                },
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031612671",
                  "owner_id"=>"grp-a001-01-000000003853231",
                  "target_tp"=>"REGIONAL_TARGET",
                  "target"=>nil,
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-18T16:31:02.000Z",
                  "edit_tm"=>"2017-07-18T16:31:02.000Z"
                },
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031612672",
                  "owner_id"=>"grp-a001-01-000000003853231",
                  "target_tp"=>"MEDIA_TARGET",
                  "target"=>{
                    "type"=>1,
                    "search"=>[],
                    "contents"=>[],
                    "white"=>{
                      "media"=>nil,
                      "media_group"=>nil
                    },
                    "black"=>{
                      "media"=>nil,
                      "media_group"=>nil
                    }
                  },
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-18T16:31:02.000Z",
                  "edit_tm"=>"2017-07-18T16:31:02.000Z"
                },
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031612673",
                  "owner_id"=>"grp-a001-01-000000003853231",
                  "target_tp"=>"PC_MOBILE_TARGET",
                  "target"=>{
                    "pc"=>true,
                    "mobile"=>true
                  },
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-18T16:31:02.000Z",
                  "edit_tm"=>"2017-07-18T16:31:02.000Z"
                }
              ],
              target_summary: {
                "week"=>"all",
                "pc_mobile"=>"all",
                "media"=>"all",
                "time"=>"all",
                "region"=>"all"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
            ), nil)
      end
    end

    context 'when requesting none existing id' do
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/adgroups/none-existing').
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
      let(:adgroup_id) { 'none-existing' }

      it {  expect{ this.get_adgroup(adgroup_id) }.to raise_error(NotEnoughPermissionError) }
    end
  end

  describe '#create_adgroup' do
    context 'when creating an adgroup with only required attributes' do
      let(:adgroup) {
        {
          'nccCampaignId' => 'cmp-a001-01-000000000652963',
          'pcChannelId' => 'bsn-a001-00-000000000043392',
          'mobileChannelId' => 'bsn-a001-00-000000000043392',
          'name' => 'test-ad-group-03'
        }
      }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/adgroups').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003864948",
  "customerId":1077530,
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "mobileChannelId":"bsn-a001-00-000000000043392",
  "pcChannelId":"bsn-a001-00-000000000043392",
  "bidAmt":70,
  "name":"test-ad-group-03",
  "userLock":false,
  "useDailyBudget":false,
  "useKeywordPlus":false,
  "keywordPlusWeight":100,
  "contentsNetworkBidAmt":70,
  "useCntsNetworkBidAmt":false,
  "mobileNetworkBidWeight":100,
  "pcNetworkBidWeight":100,
  "dailyBudget":0,
  "budgetLock":false,
  "delFlag":false,
  "regTm":"2017-07-19T10:43:17.000Z",
  "editTm":"2017-07-19T10:43:17.000Z",
  "targets":[
    {
      "nccTargetId":"tgt-a001-01-000000031696167",
      "ownerId":"grp-a001-01-000000003864948",
      "targetTp":"TIME_WEEKLY_TARGET",
      "target":null,
      "delFlag":false,
      "regTm":"2017-07-19T10:43:17.000Z",
      "editTm":"2017-07-19T10:43:17.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031696168",
      "ownerId":"grp-a001-01-000000003864948",
      "targetTp":"REGIONAL_TARGET",
      "target":null,
      "delFlag":false,
      "regTm":"2017-07-19T10:43:17.000Z",
      "editTm":"2017-07-19T10:43:17.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031696169",
      "ownerId":"grp-a001-01-000000003864948",
      "targetTp":"MEDIA_TARGET",
      "target":{
        "type":1,
        "search":[],
        "contents":[],
        "white":{
          "media":null,
          "mediaGroup":null
        },
        "black":{
          "media":null,
          "mediaGroup":null
        }
      },
      "delFlag":false,
      "regTm":"2017-07-19T10:43:17.000Z",
      "editTm":"2017-07-19T10:43:17.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031696170",
      "ownerId":"grp-a001-01-000000003864948",
      "targetTp":"PC_MOBILE_TARGET",
      "target":{
        "pc":true,
        "mobile":true
      },
      "delFlag":false,
      "regTm":"2017-07-19T10:43:17.000Z",
      "editTm":"2017-07-19T10:43:17.000Z"
    }
  ],
  "targetSummary":{
    "week":"all",
    "pcMobile":"all",
    "media":"all",
    "time":"all",
    "region":"all"
  },
  "pcChannelKey":"http://www.mymemodel.com",
  "mobileChannelKey":"http://www.mymemodel.com",
  "status":"PAUSED",
  "statusReason":"CAMPAIGN_PENDING",
  "expectCost":0,
  "migType":0,
  "adgroupAttrJson":{"campaignTp":1}
}
JSON
          )
      end

      it 'should return relevant adgroup object filled with default values' do
        expect { |b| this.create_adgroup(adgroup, &b) }.
          to yield_with_args(OpenStruct.new(
            ncc_adgroup_id: "grp-a001-01-000000003864948",
            customer_id: 1077530,
            ncc_campaign_id: "cmp-a001-01-000000000652963",
            mobile_channel_id: "bsn-a001-00-000000000043392",
            pc_channel_id: "bsn-a001-00-000000000043392",
            bid_amt: 70,
            name: "test-ad-group-03",
            user_lock: false,
            use_daily_budget: false,
            use_keyword_plus: false,
            keyword_plus_weight: 100,
            contents_network_bid_amt: 70,
            use_cnts_network_bid_amt: false,
            mobile_network_bid_weight: 100,
            pc_network_bid_weight: 100,
            daily_budget: 0,
            budget_lock: false,
            del_flag: false,
            reg_tm: "2017-07-19T10:43:17.000Z",
            edit_tm: "2017-07-19T10:43:17.000Z",
            targets: [
              {
                "ncc_target_id"=>"tgt-a001-01-000000031696167",
                "owner_id"=>"grp-a001-01-000000003864948",
                "target_tp"=>"TIME_WEEKLY_TARGET",
                "target"=>nil,
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T10:43:17.000Z",
                "edit_tm"=>"2017-07-19T10:43:17.000Z"
              },
              {
                "ncc_target_id"=>"tgt-a001-01-000000031696168",
                "owner_id"=>"grp-a001-01-000000003864948",
                "target_tp"=>"REGIONAL_TARGET",
                "target"=>nil,
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T10:43:17.000Z",
                "edit_tm"=>"2017-07-19T10:43:17.000Z"
              },
              {
                "ncc_target_id"=>"tgt-a001-01-000000031696169",
                "owner_id"=>"grp-a001-01-000000003864948",
                "target_tp"=>"MEDIA_TARGET",
                "target"=>{
                  "type"=>1,
                  "search"=>[],
                  "contents"=>[],
                  "white"=>{
                    "media"=>nil,
                    "media_group"=>nil
                  },
                  "black"=>{
                    "media"=>nil,
                    "media_group"=>nil
                  }
                },
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T10:43:17.000Z",
                "edit_tm"=>"2017-07-19T10:43:17.000Z"
              },
              {
                "ncc_target_id"=>"tgt-a001-01-000000031696170",
                "owner_id"=>"grp-a001-01-000000003864948",
                "target_tp"=>"PC_MOBILE_TARGET",
                "target"=>{
                  "pc"=>true,
                  "mobile"=>true
                },
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T10:43:17.000Z",
                "edit_tm"=>"2017-07-19T10:43:17.000Z"
              }
            ],
            target_summary: {
              "week"=>"all",
              "pc_mobile"=>"all",
              "media"=>"all",
              "time"=>"all",
              "region"=>"all"
            },
            pc_channel_key: "http://www.mymemodel.com",
            mobile_channel_key: "http://www.mymemodel.com",
            status: "PAUSED",
            status_reason: "CAMPAIGN_PENDING",
            expect_cost: 0,
            mig_type: 0,
            adgroup_attr_json: {"campaign_tp"=>1}
            ), nil)
      end
    end

    context 'when creating a adgroup with existing name' do
      let(:adgroup) {
        {
          'nccCampaignId' => 'cmp-a001-01-000000000652963',
          'pcChannelId' => 'bsn-a001-00-000000000043392',
          'mobileChannelId' => 'bsn-a001-00-000000000043392',
          'name' => 'existing-name'
        }
      }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/adgroups').
          to_return(
            status: 400,
            body: <<-JSON
{
  "code":3710,
  "status":400,
  "title":"An ad group with the same name already exists."
}
JSON
            )
      end

      it { expect { this.create_adgroup(adgroup) }.to raise_error(DuplicatedAdgroupNameError) }
    end

    context 'when missing required attributes in request object' do
      let(:adgroup) {
        {
          'nccCampaignId' => 'cmp-a001-01-000000000652963',
          'name' => 'existing-name'
        }
      }

      it { expect { this.create_adgroup(adgroup) }.to raise_error(MissingRequiredAttributeError) }
    end

    context 'when creating an adgroup with more options' do
      let(:adgroup) {
        {
          'nccCampaignId' => 'cmp-a001-01-000000000652963',
          'pcChannelId' => 'bsn-a001-00-000000000043392',
          'mobileChannelId' => 'bsn-a001-00-000000000043392',
          'name' => 'test-ad-group-04',
          'bidAmt' => 100,
          'dailyBudget' => 100,
          'contentsNetworkBidAmt' => 30,
          'keywordPlusWeight' => 80,
          'mobileNetworkBidWeight' => 40,
          'pcNetworkBidWeight' => 40,
          'useCntsNetworkBidAmt' => true,
          'useDailyBudget' => true,
          'useKeywordPlus' => false,
          'userLock' => false
        }
      }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/adgroups').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "mobileChannelId":"bsn-a001-00-000000000043392",
  "pcChannelId":"bsn-a001-00-000000000043392",
  "bidAmt":100,
  "name":"test-ad-group-04",
  "userLock":false,
  "useDailyBudget":true,
  "useKeywordPlus":false,
  "keywordPlusWeight":80,
  "contentsNetworkBidAmt":30,
  "useCntsNetworkBidAmt":true,
  "mobileNetworkBidWeight":40,
  "pcNetworkBidWeight":40,
  "dailyBudget":100,
  "budgetLock":false,
  "delFlag":false,
  "regTm":"2017-07-19T11:05:25.000Z",
  "editTm":"2017-07-19T11:05:25.000Z",
  "targets":[
    {
      "nccTargetId":"tgt-a001-01-000000031700712",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"TIME_WEEKLY_TARGET",
      "target":null,
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T11:05:25.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031700713",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"REGIONAL_TARGET",
      "target":null,
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T11:05:25.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031700714",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"MEDIA_TARGET",
      "target":{
        "type":1,
        "search":[],
        "contents":[],
        "white":{
          "media":null,
          "mediaGroup":null
        },
        "black":{
          "media":null,
          "mediaGroup":null
        }
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T11:05:25.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031700715",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"PC_MOBILE_TARGET",
      "target":{
        "pc":true,
        "mobile":true
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T11:05:25.000Z"
    }
  ],
  "targetSummary":{
    "week":"all",
    "pcMobile":"all",
    "media":"all",
    "time":"all",
    "region":"all"
  },
  "pcChannelKey":"http://www.mymemodel.com",
  "mobileChannelKey":"http://www.mymemodel.com",
  "status":"PAUSED",
  "statusReason":"CAMPAIGN_PENDING",
  "expectCost":0,
  "migType":0,
  "adgroupAttrJson":{"campaignTp":1}
}
JSON
            )
      end

      it 'should create an adgroup with the given options' do
        expect { |b| this.create_adgroup(adgroup, &b) }.
          to yield_with_args(OpenStruct.new(
            ncc_adgroup_id: "grp-a001-01-000000003865468",
            customer_id: 1077530,
            ncc_campaign_id: "cmp-a001-01-000000000652963",
            mobile_channel_id: "bsn-a001-00-000000000043392",
            pc_channel_id: "bsn-a001-00-000000000043392",
            bid_amt: 100,
            name: "test-ad-group-04",
            user_lock: false,
            use_daily_budget: true,
            use_keyword_plus: false,
            keyword_plus_weight: 80,
            contents_network_bid_amt: 30,
            use_cnts_network_bid_amt: true,
            mobile_network_bid_weight: 40,
            pc_network_bid_weight: 40,
            daily_budget: 100,
            budget_lock: false,
            del_flag: false,
            reg_tm: "2017-07-19T11:05:25.000Z",
            edit_tm: "2017-07-19T11:05:25.000Z",
            targets: [
              {
                "ncc_target_id"=>"tgt-a001-01-000000031700712",
                "owner_id"=>"grp-a001-01-000000003865468",
                "target_tp"=>"TIME_WEEKLY_TARGET",
                "target"=>nil,
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T11:05:25.000Z",
                "edit_tm"=>"2017-07-19T11:05:25.000Z"
              },
              {
                "ncc_target_id"=>"tgt-a001-01-000000031700713",
                "owner_id"=>"grp-a001-01-000000003865468",
                "target_tp"=>"REGIONAL_TARGET",
                "target"=>nil,
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T11:05:25.000Z",
                "edit_tm"=>"2017-07-19T11:05:25.000Z"
              },
              {
                "ncc_target_id"=>"tgt-a001-01-000000031700714",
                "owner_id"=>"grp-a001-01-000000003865468",
                "target_tp"=>"MEDIA_TARGET",
                "target"=>{
                  "type"=>1,
                  "search"=>[],
                  "contents"=>[],
                  "white"=>{
                    "media"=>nil,
                    "media_group"=>nil
                  },
                  "black"=>{
                    "media"=>nil,
                    "media_group"=>nil
                  }
                },
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T11:05:25.000Z",
                "edit_tm"=>"2017-07-19T11:05:25.000Z"
              },
              {
                "ncc_target_id"=>"tgt-a001-01-000000031700715",
                "owner_id"=>"grp-a001-01-000000003865468",
                "target_tp"=>"PC_MOBILE_TARGET",
                "target"=>{
                  "pc"=>true,
                  "mobile"=>true
                },
                "del_flag"=>false,
                "reg_tm"=>"2017-07-19T11:05:25.000Z",
                "edit_tm"=>"2017-07-19T11:05:25.000Z"
              }
            ],
            target_summary: {
              "week"=>"all",
              "pc_mobile"=>"all",
              "media"=>"all",
              "time"=>"all",
              "region"=>"all"
            },
            pc_channel_key: "http://www.mymemodel.com",
            mobile_channel_key: "http://www.mymemodel.com",
            status: "PAUSED",
            status_reason: "CAMPAIGN_PENDING",
            expect_cost: 0,
            mig_type: 0,
            adgroup_attr_json: {"campaign_tp"=>1}
          ), nil)
      end
    end
  end

  describe '#update_adgroup' do
    context 'when all ok' do
      context 'with userLock field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'userLock' => false
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=userLock').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "bidAmt":100,
  "name":"test-ad-group-04",
  "userLock":false,
  "useDailyBudget":true,
  "useKeywordPlus":false,
  "keywordPlusWeight":80,
  "contentsNetworkBidAmt":30,
  "useCntsNetworkBidAmt":true,
  "mobileNetworkBidWeight":40,
  "pcNetworkBidWeight":40,
  "dailyBudget":100,
  "budgetLock":false
}
JSON
          )
        end

        it 'should update userLock' do
          result = this.update_adgroup(adgroup, field: 'userLock')
          expect(result.user_lock).to eq(false)
        end
      end

      context 'with bidAmt field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'bidAmt' => 120
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=bidAmt').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "bidAmt":120,
  "name":"test-ad-group-04",
  "userLock":false,
  "useDailyBudget":true,
  "useKeywordPlus":false,
  "keywordPlusWeight":80,
  "contentsNetworkBidAmt":30,
  "useCntsNetworkBidAmt":true,
  "mobileNetworkBidWeight":40,
  "pcNetworkBidWeight":40,
  "dailyBudget":100,
  "budgetLock":false
}
JSON
          )
        end

        it 'should update bidAmt' do
          result = this.update_adgroup(adgroup, field: 'bidAmt')
          expect(result.bid_amt).to eq(120)
        end
      end

      context 'with budget field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'dailyBudget' => 90,
            'useDailyBudget' => true
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=budget').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "bidAmt":120,
  "name":"test-ad-group-04",
  "userLock":false,
  "useDailyBudget":true,
  "useKeywordPlus":false,
  "keywordPlusWeight":80,
  "contentsNetworkBidAmt":30,
  "useCntsNetworkBidAmt":true,
  "mobileNetworkBidWeight":40,
  "pcNetworkBidWeight":40,
  "dailyBudget":90,
  "budgetLock":false
}
JSON
          )
        end

        it 'should update dailyBudget and useDailyBudget' do
          result = this.update_adgroup(adgroup, field: 'budget')
          expect(result.daily_budget).to eq(90)
          expect(result.use_daily_budget).to eq(true)
        end
      end

      context 'with useKeywordPlus field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'useKeywordPlus' => true,
            'keywordPlusWeight' => 75
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=useKeywordPlus').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "bidAmt":120,
  "name":"test-ad-group-04",
  "userLock":false,
  "useDailyBudget":true,
  "useKeywordPlus":true,
  "keywordPlusWeight":75,
  "contentsNetworkBidAmt":30,
  "useCntsNetworkBidAmt":true,
  "mobileNetworkBidWeight":40,
  "pcNetworkBidWeight":40,
  "dailyBudget":90,
  "budgetLock":false
}
JSON
          )
        end

        it 'should update both useKeywordPlus and keywordPlusWeight' do
          result = this.update_adgroup(adgroup, field: 'useKeywordPlus')
          expect(result.use_keyword_plus).to eq(true)
          expect(result.keyword_plus_weight).to eq(75)
        end
      end

      context 'with networkBidWeight field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'mobileNetworkBidWeight' => 55,
            'pcNetworkBidWeight' => 50
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=networkBidWeight').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "bidAmt":120,
  "name":"test-ad-group-04",
  "userLock":false,
  "useDailyBudget":true,
  "useKeywordPlus":true,
  "keywordPlusWeight":75,
  "contentsNetworkBidAmt":30,
  "useCntsNetworkBidAmt":true,
  "mobileNetworkBidWeight":55,
  "pcNetworkBidWeight":50,
  "dailyBudget":90,
  "budgetLock":false
}
JSON
          )
        end

        it 'should update either mobileNetworkBidWeight or pcNetworkBidWeight' do
          result = this.update_adgroup(adgroup, field: 'networkBidWeight')
          expect(result.mobile_network_bid_weight).to eq(55)
          expect(result.pc_network_bid_weight).to eq(50)
        end
      end

      context 'with targetLocation field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'targets' => [
              {
                "nccTargetId" => "tgt-a001-01-000000031700713",
                "ownerId" => "grp-a001-01-000000003865468",
                "targetTp" => "REGIONAL_TARGET",
                "target" => {
                  "location" => {
                    "KR" => [
                      "09",
                      "05",
                      "06",
                      "07",
                      "10",
                      "16",
                      "14"
                    ],
                    "OTHERS" => [
                      "00"
                    ]
                  }
                }
              }
            ]
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=targetLocation').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "targets":[
    {
      "nccTargetId":"tgt-a001-01-000000031700713",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"REGIONAL_TARGET",
      "target":{
        "location":{
          "KR":[
            "09", "05", "06", "07", "10", "16", "14"
          ],
          "OTHERS":["00"]
        }
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T14:57:27.000Z"
    }
  ]
}
JSON
          )
        end

        it 'should update REGIONAL_TARGET target' do
          result = this.update_adgroup(adgroup, field: 'targetLocation')
          expect(result.targets[0]['target']['location']['kr']).
            to eq(%w[09 05 06 07 10 16 14])
          expect(result.targets[0]['target']['location']['others']).
            to eq(%w[00])
        end
      end

      context 'with targetTime field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'targets' => [
              {
                'nccTargetId' => 'tgt-a001-01-000000031700712',
                'ownerId' => 'grp-a001-01-000000003865468',
                'targetTp' => 'TIME_WEEKLY_TARGET',
                'target' => {
                  'mon' => 0,
                  'tue' => 15695615,
                  'wed' => 15695615,
                  'thu' => 15695615,
                  'fri' => 15695615,
                  'sat' => 15695615,
                  'sun' => 15695615
                }
              },
            ]
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=targetTime').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "targets":[
    {
      "nccTargetId":"tgt-a001-01-000000031700712",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"TIME_WEEKLY_TARGET",
      "target":{
        "MON":0,
        "TUE":15695615,
        "WED":15695615,
        "THU":15695615,
        "FRI":15695615,
        "SAT":15695615,
        "SUN":15695615
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T15:08:11.000Z"
    }
  ]
}
JSON
          )
        end

        it 'should update TIME_WEEKLY_TARGET target' do
          result = this.update_adgroup(adgroup, field: 'targetTime')
          expect(result.targets[0]['target']['mon']).to eq(0)
          expect(result.targets[0]['target']['tue']).to eq(15695615)
          expect(result.targets[0]['target']['wed']).to eq(15695615)
          expect(result.targets[0]['target']['fri']).to eq(15695615)
          expect(result.targets[0]['target']['sat']).to eq(15695615)
          expect(result.targets[0]['target']['sun']).to eq(15695615)
        end
      end

      context 'with targetMedia field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'targets' => [
              {
                'nccTargetId' => 'tgt-a001-01-000000031700714',
                'ownerId' => 'grp-a001-01-000000003865468',
                'targetTp' => 'MEDIA_TARGET',
                'target' => {
                  'type' => 3,
                  'white' => {
                    'media' => [11068, 27758, 122875],
                    'mediaGroup' => [1]
                  },
                  'search' => [],
                  'contents' => [],
                  'black' => {
                    'media' => nil,
                    'mediaGroup' => nil
                  }
                }
              },
              {
                'nccTargetId' => 'tgt-a001-01-000000031700715',
                'ownerId' => 'grp-a001-01-000000003865468',
                'targetTp' => 'PC_MOBILE_TARGET',
                'target' => {
                  'pc' => false,
                  'mobile' => true
                }
              }
            ]
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468?fields=targetMedia').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "targets":[
    {
      "nccTargetId":"tgt-a001-01-000000031700714",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"MEDIA_TARGET",
      "target":{
        "type":3,
        "white":{
          "media":[11068,27758,122875],
          "mediaGroup":[1]
        },
        "search":[],
        "contents":[],
        "black":{
          "media":null,
          "mediaGroup":null
        }
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T15:26:33.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031700715",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"PC_MOBILE_TARGET",
      "target":{
        "pc":false,
        "mobile":true
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T15:26:33.000Z"
    }
  ]
}
JSON
          )
        end

        it 'should update MEDIA_TARGET and PC_MOBILE_TARGET targets' do
          result = this.update_adgroup(adgroup, field: 'targetMedia')
          expect(result.targets[0]['target']['white']['media']).to eq([11068, 27758, 122875])
          expect(result.targets[1]['target']['pc']).to eq(false)
          expect(result.targets[1]['target']['mobile']).to eq(true)
        end
      end

      context 'without specific field' do
        let(:adgroup) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccCampaignId' => 'cmp-a001-01-000000000652963',
            'pcChannelId' => 'bsn-a001-00-000000000043392',
            'mobileChannelId' => 'bsn-a001-00-000000000043392',
            'name' => 'test-ad-group-04',
            'bidAmt' => 100,
            'dailyBudget' => 100,
            'contentsNetworkBidAmt' => 100,
            'keywordPlusWeight' => 80,
            'mobileNetworkBidWeight' => 40,
            'pcNetworkBidWeight' => 40,
            'useCntsNetworkBidAmt' => true,
            'useDailyBudget' => true,
            'useKeywordPlus' => true,
            'userLock' => false,
            'targets' => [
              {
                "nccTargetId" => "tgt-a001-01-000000031700713",
                "ownerId" => "grp-a001-01-000000003865468",
                "targetTp" => "REGIONAL_TARGET",
                "target" => {
                  "location" => {
                    "KR" => ["09", "05", "06"],
                    "OTHERS" => ["00"]
                  }
                }
              },
              {
                'nccTargetId' => 'tgt-a001-01-000000031700712',
                'ownerId' => 'grp-a001-01-000000003865468',
                'targetTp' => 'TIME_WEEKLY_TARGET',
                'target' => {
                  'MON' => 0,
                  'TUE' => 0,
                  'WED' => 15695615,
                  'THU' => 15695615,
                  'FRI' => 15695615,
                  'SAT' => 15695615,
                  'SUN' => 15695615
                }
              },
              {
                'nccTargetId' => 'tgt-a001-01-000000031700714',
                'ownerId' => 'grp-a001-01-000000003865468',
                'targetTp' => 'MEDIA_TARGET',
                'target' => {
                  'type' => 3,
                  'white' => {
                    'media' => [11068, 27758, 122875],
                    'mediaGroup' => [1]
                  },
                  'search' => [],
                  'contents' => [],
                  'black' => {
                    'media' => nil,
                    'mediaGroup' => nil
                  }
                }
              },
              {
                'nccTargetId' => 'tgt-a001-01-000000031700715',
                'ownerId' => 'grp-a001-01-000000003865468',
                'targetTp' => 'PC_MOBILE_TARGET',
                'target' => {
                  'pc' => true,
                  'mobile' => true
                }
              }
            ]
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003865468').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "mobileChannelId":"bsn-a001-00-000000000043392",
  "pcChannelId":"bsn-a001-00-000000000043392",
  "bidAmt":100,
  "name":"test-ad-group-04",
  "userLock":false,
  "useDailyBudget":true,
  "useKeywordPlus":true,
  "keywordPlusWeight":75,
  "contentsNetworkBidAmt":100,
  "useCntsNetworkBidAmt":true,
  "mobileNetworkBidWeight":40,
  "pcNetworkBidWeight":40,
  "dailyBudget":100,
  "budgetLock":false,
  "delFlag":false,
  "regTm":"2017-07-19T11:05:25.000Z",
  "editTm":"2017-07-19T13:46:48.000Z",
  "targets":[
    {
      "nccTargetId":"tgt-a001-01-000000031700712",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"TIME_WEEKLY_TARGET",
      "target":{
        "MON":0,
        "TUE":0,
        "WED":15695615,
        "THU":15695615,
        "FRI":15695615,
        "SAT":15695615,
        "SUN":15695615
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T15:33:18.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031700713",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"REGIONAL_TARGET",
      "target":{
        "location":{
          "KR":["09","05","06"],
          "OTHERS":["00"]
        }
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T15:31:33.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031700714",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"MEDIA_TARGET",
      "target":{
        "type":3,
        "white":{
          "media":[11068,27758,122875],
          "mediaGroup":[1]
        },
        "search":[],
        "contents":[],
        "black":{
          "media":null,
          "mediaGroup":null
        }
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T15:26:33.000Z"
    },
    {
      "nccTargetId":"tgt-a001-01-000000031700715",
      "ownerId":"grp-a001-01-000000003865468",
      "targetTp":"PC_MOBILE_TARGET",
      "target":{
        "pc":true,
        "mobile":true
      },
      "delFlag":false,
      "regTm":"2017-07-19T11:05:25.000Z",
      "editTm":"2017-07-19T15:34:02.000Z"
    }
  ],
  "targetSummary":{
    "pcMobile":"all",
    "media":"partially",
    "time":"partially",
    "region":"partially"
  },
  "pcChannelKey":"http://www.mymemodel.com",
  "mobileChannelKey":"http://www.mymemodel.com",
  "status":"PAUSED",
  "statusReason":"CAMPAIGN_PENDING",
  "expectCost":0,
  "migType":0,
  "adgroupAttrJson":{"campaignTp":1}
}
JSON
          )
        end

        it 'should update all given fields' do
          expect { |b| this.update_adgroup(adgroup, &b) }.
            to yield_with_args(OpenStruct.new(
              ncc_adgroup_id: "grp-a001-01-000000003865468",
              customer_id: 1077530,
              ncc_campaign_id: "cmp-a001-01-000000000652963",
              mobile_channel_id: "bsn-a001-00-000000000043392",
              pc_channel_id: "bsn-a001-00-000000000043392",
              bid_amt: 100,
              name: "test-ad-group-04",
              user_lock: false,
              use_daily_budget: true,
              use_keyword_plus: true,
              keyword_plus_weight: 75,
              contents_network_bid_amt: 100,
              use_cnts_network_bid_amt: true,
              mobile_network_bid_weight: 40,
              pc_network_bid_weight: 40,
              daily_budget: 100,
              budget_lock: false,
              del_flag: false,
              reg_tm: "2017-07-19T11:05:25.000Z",
              edit_tm: "2017-07-19T13:46:48.000Z",
              targets: [
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031700712",
                  "owner_id"=>"grp-a001-01-000000003865468",
                  "target_tp"=>"TIME_WEEKLY_TARGET",
                  "target"=>{
                    "mon"=>0,
                    "tue"=>0,
                    "wed"=>15695615,
                    "thu"=>15695615,
                    "fri"=>15695615,
                    "sat"=>15695615,
                    "sun"=>15695615
                  },
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-19T11:05:25.000Z",
                  "edit_tm"=>"2017-07-19T15:33:18.000Z"
                },
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031700713",
                  "owner_id"=>"grp-a001-01-000000003865468",
                  "target_tp"=>"REGIONAL_TARGET",
                  "target"=>{
                    "location"=>{
                      "kr"=>["09","05","06"],
                      "others"=>["00"]
                    }
                  },
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-19T11:05:25.000Z",
                  "edit_tm"=>"2017-07-19T15:31:33.000Z"
                },
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031700714",
                  "owner_id"=>"grp-a001-01-000000003865468",
                  "target_tp"=>"MEDIA_TARGET",
                  "target"=>{
                    "type"=>3,
                    "white"=>{
                      "media"=>[11068,27758,122875],
                      "media_group"=>[1]
                    },
                    "search"=>[],
                    "contents"=>[],
                    "black"=>{
                      "media"=>nil,
                      "media_group"=>nil
                    }
                  },
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-19T11:05:25.000Z",
                  "edit_tm"=>"2017-07-19T15:26:33.000Z"
                },
                {
                  "ncc_target_id"=>"tgt-a001-01-000000031700715",
                  "owner_id"=>"grp-a001-01-000000003865468",
                  "target_tp"=>"PC_MOBILE_TARGET",
                  "target"=>{
                    "pc"=>true,
                    "mobile"=>true
                  },
                  "del_flag"=>false,
                  "reg_tm"=>"2017-07-19T11:05:25.000Z",
                  "edit_tm"=>"2017-07-19T15:34:02.000Z"
                }
              ],
              target_summary: {
                "pc_mobile"=>"all",
                "media"=>"partially",
                "time"=>"partially",
                "region"=>"partially"
              },
              pc_channel_key: "http://www.mymemodel.com",
              mobile_channel_key: "http://www.mymemodel.com",
              status: "PAUSED",
              status_reason: "CAMPAIGN_PENDING",
              expect_cost: 0,
              mig_type: 0,
              adgroup_attr_json: {"campaign_tp"=>1}
              ), nil)
        end
      end
    end
  end

  describe '#delete_adgroup' do
    context 'when all ok' do
      let(:adgroup_id) { 'grp-a001-01-000000003853231' }

      before(:each) do
        stub_request(:delete, 'https://api.naver.com/ncc/adgroups/grp-a001-01-000000003853231').
          to_return(status: 204)
      end

      it 'should delete the given adgroup' do
        expect { |b| this.delete_adgroup(adgroup_id, &b) }.to yield_with_args('', nil)
      end
    end

    context 'when given campaign id does not exist' do
      let(:adgroup_id) { 'none-existing' }

      before(:each) do
        stub_request(:delete, 'https://api.naver.com/ncc/adgroups/none-existing').
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

      it { expect{ this.delete_adgroup(adgroup_id) }.to raise_error(NotEnoughPermissionError) }
    end
  end
end
