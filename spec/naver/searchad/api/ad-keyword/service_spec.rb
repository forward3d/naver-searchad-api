require 'spec_helper'

include Naver::Searchad::Api

describe AdKeyword::Service do
  subject(:this) { described_class.new }
  before(:each) do
    this.authorization = Auth.get_application_default
  end

  describe '#list_ad_keywords_by_ids' do
    context 'when requesting more than one' do
      let(:ids) {['nkw-a001-01-000000723631063', 'nkw-a001-01-000000723631064']}
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/keywords?ids=nkw-a001-01-000000723631063,nkw-a001-01-000000723631064').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000723631063",
    "keyword":"TEST-KEYWORD-00",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-19T16:56:41.000Z",
    "editTm":"2017-07-19T16:56:41.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  },
  {
    "nccKeywordId":"nkw-a001-01-000000723631064",
    "keyword":"TEST-KEYWORD-01",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-19T16:56:55.000Z",
    "editTm":"2017-07-19T16:56:55.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  }
]
JSON
        )
      end

      it 'should return an array of relevant ad keywords' do
        expect { |b| this.list_ad_keywords_by_ids(ids, &b) }.
          to yield_with_args([
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000723631063',
              keyword: 'TEST-KEYWORD-00',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-19T16:56:41.000Z',
              edit_tm: '2017-07-19T16:56:41.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}
            ),
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000723631064',
              keyword: 'TEST-KEYWORD-01',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-19T16:56:55.000Z',
              edit_tm: '2017-07-19T16:56:55.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}
            )
          ], nil)
      end
    end
  end

  describe '#list_ad_keywords_by_adgroup_id' do
    context 'when all ok' do
      let(:adgroup_id) { 'grp-a001-01-000000003865468' }
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/keywords?nccAdgroupId=grp-a001-01-000000003865468').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000723631063",
    "keyword":"TEST-KEYWORD-00",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-19T16:56:41.000Z",
    "editTm":"2017-07-19T16:56:41.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  },
  {
    "nccKeywordId":"nkw-a001-01-000000723631064",
    "keyword":"TEST-KEYWORD-01",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-19T16:56:55.000Z",
    "editTm":"2017-07-19T16:56:55.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  }
]
JSON
        )
      end

      it 'should return an array of relevant ad keywords' do
        expect { |b| this.list_ad_keywords_by_adgroup_id(adgroup_id, &b) }.
          to yield_with_args([
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000723631063',
              keyword: 'TEST-KEYWORD-00',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-19T16:56:41.000Z',
              edit_tm: '2017-07-19T16:56:41.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}
            ),
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000723631064',
              keyword: 'TEST-KEYWORD-01',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-19T16:56:55.000Z',
              edit_tm: '2017-07-19T16:56:55.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}
            )
          ], nil)
      end
    end
  end

  describe '#list_ad_keywords_by_label_id' do
    context 'when all ok' do
      let(:label_id) { 'label_id' }
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/keywords?nccLabelId=label_id').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000723631063",
    "keyword":"TEST-KEYWORD-00",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-19T16:56:41.000Z",
    "editTm":"2017-07-19T16:56:41.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  },
  {
    "nccKeywordId":"nkw-a001-01-000000723631064",
    "keyword":"TEST-KEYWORD-01",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-19T16:56:55.000Z",
    "editTm":"2017-07-19T16:56:55.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  }
]
JSON
        )
      end

      it 'should return an array of relevant ad keywords' do
        expect { |b| this.list_ad_keywords_by_label_id(label_id, &b) }.
          to yield_with_args([
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000723631063',
              keyword: 'TEST-KEYWORD-00',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-19T16:56:41.000Z',
              edit_tm: '2017-07-19T16:56:41.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}
            ),
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000723631064',
              keyword: 'TEST-KEYWORD-01',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-19T16:56:55.000Z',
              edit_tm: '2017-07-19T16:56:55.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}
            )
          ], nil)
      end
    end
  end

  describe '#get_ad_keyword' do
    context 'when all ok' do
      let(:ad_keyword_id) { 'nkw-a001-01-000000723631063' }
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000723631063').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccKeywordId":"nkw-a001-01-000000723631063",
  "keyword":"TEST-KEYWORD-00",
  "customerId":1077530,
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "nccCampaignId":"cmp-a001-01-000000000652963",
  "userLock":false,
  "inspectStatus":"UNDER_REVIEW",
  "bidAmt":70,
  "useGroupBidAmt":true,
  "regTm":"2017-07-19T16:56:41.000Z",
  "editTm":"2017-07-19T16:56:41.000Z",
  "status":"PAUSED",
  "statusReason":"KEYWORD_UNDER_REVIEW",
  "nccQi":{"qiGrade":4}
}
JSON
        )
      end

      it 'should relevant ad keyword' do
        expect { |b| this.get_ad_keyword(ad_keyword_id, &b) }.
          to yield_with_args(
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000723631063',
              keyword: 'TEST-KEYWORD-00',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-19T16:56:41.000Z',
              edit_tm: '2017-07-19T16:56:41.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}
            ), nil
          )
      end
    end
  end

  describe '#create_ad_keyword' do

  end

  describe '#update_ad_keyword' do
  end

  describe '#delete_ad_keyword' do
    context 'when all ok' do
      let(:ad_keyword_id) { 'nkw-a001-01-000000723631063' }

      before(:each) do
        stub_request(:delete, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000723631063').
          to_return(status: 204)
      end

      it 'should delete the given ad keyword' do
        expect { |b| this.delete_ad_keyword(ad_keyword_id, {}, &b) }.
          to yield_with_args('', nil)
      end
    end
  end
end
