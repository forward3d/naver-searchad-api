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
    let(:adgroup_id) { 'grp-a001-01-000000003865468' }

    context 'when creating an ad keyword with only required attribute' do
      let(:ad_keyword) { { 'keyword' => 'test-keyword-02' } }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/keywords?nccAdgroupId=grp-a001-01-000000003865468').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000723635068",
    "keyword":"TEST-KEYWORD-02",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-19T17:31:32.000Z",
    "editTm":"2017-07-19T17:31:32.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  }
]
JSON
        )
      end

      it 'should create an ad keyword filled with default values' do
        expect { |b| this.create_ad_keywords([ad_keyword], adgroup_id, &b) }.
          to yield_with_args(
            [
              OpenStruct.new(
                ncc_keyword_id: 'nkw-a001-01-000000723635068',
                keyword: 'TEST-KEYWORD-02',
                customer_id: 1077530,
                ncc_adgroup_id: 'grp-a001-01-000000003865468',
                ncc_campaign_id: 'cmp-a001-01-000000000652963',
                user_lock: false,
                inspect_status: 'UNDER_REVIEW',
                bid_amt: 70,
                use_group_bid_amt: true,
                reg_tm: '2017-07-19T17:31:32.000Z',
                edit_tm: '2017-07-19T17:31:32.000Z',
                status: 'PAUSED',
                status_reason: 'KEYWORD_UNDER_REVIEW',
                ncc_qi: {'qi_grade'=>4}
              )
            ], nil
          )
      end
    end

    context 'when missing required attribute in request object' do
      let(:ad_keyword) { { } }

      it { expect{ this.create_ad_keywords([ad_keyword], adgroup_id) }.to raise_error(MissingRequiredAttributeError) }
    end

    context 'when creating an ad keyword with all fields' do
      let(:ad_keyword) {
        {
          'keyword' => 'test-keyword-03',
          'bidAmt' => 110,
          'useGroupBidAmt' => true,
          'links' => {
            'pc' => {
              'final' => 'http://forward3d.com'
            },
            'mobile' => {
              'final' => 'http://forward3d.com'
            }
          },
          'userLock' => true
        }
      }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/keywords?nccAdgroupId=grp-a001-01-000000003865468').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000725737022",
    "keyword":"TEST-KEYWORD-03",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "links":{
      "pc":{
        "final":"http://forward3d.com",
        "punyCode":"http://forward3d.com"
      },
      "mobile":{
        "final":"http://forward3d.com",
        "punyCode":"http://forward3d.com"
      }
    },
    "userLock":true,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":110,
    "useGroupBidAmt":true,
    "regTm":"2017-07-20T10:28:34.000Z",
    "editTm":"2017-07-20T10:28:34.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  }
]
JSON
        )
      end

      it 'should create an ad keyword with given fields' do
        expect { |b| this.create_ad_keywords([ad_keyword], adgroup_id, &b) }.
          to yield_with_args(
            [
              OpenStruct.new(
                ncc_keyword_id: 'nkw-a001-01-000000725737022',
                keyword: 'TEST-KEYWORD-03',
                customer_id: 1077530,
                ncc_adgroup_id: 'grp-a001-01-000000003865468',
                ncc_campaign_id: 'cmp-a001-01-000000000652963',
                links: {
                  'pc'=>{
                    'final'=>'http://forward3d.com',
                    'puny_code'=>'http://forward3d.com'
                  },
                  'mobile'=>{
                    'final'=>'http://forward3d.com',
                    'puny_code'=>'http://forward3d.com'
                  }
                },
                user_lock: true,
                inspect_status: 'UNDER_REVIEW',
                bid_amt: 110,
                use_group_bid_amt: true,
                reg_tm: '2017-07-20T10:28:34.000Z',
                edit_tm: '2017-07-20T10:28:34.000Z',
                status: 'PAUSED',
                status_reason: 'KEYWORD_UNDER_REVIEW',
                ncc_qi: {'qi_grade'=>4}
              )
            ], nil
          )
      end
    end

    context 'when creating multiple items' do
      let(:ad_keywords) {
        [
          { 'keyword' => 'test-keyword-04' },
          { 'keyword' => 'test-keyword-05' }
        ]
      }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/keywords?nccAdgroupId=grp-a001-01-000000003865468').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000725744769",
    "keyword":"TEST-KEYWORD-04",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-20T10:36:41.000Z",
    "editTm":"2017-07-20T10:36:41.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  },
  {
    "nccKeywordId":"nkw-a001-01-000000725744770",
    "keyword":"TEST-KEYWORD-05",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "regTm":"2017-07-20T10:36:41.000Z",
    "editTm":"2017-07-20T10:36:41.000Z",
    "status":"PAUSED",
    "statusReason":"KEYWORD_UNDER_REVIEW",
    "nccQi":{"qiGrade":4}
  }
]
JSON
          )
      end

      it 'should create multiple ad keywords' do
        expect { |b| this.create_ad_keywords(ad_keywords, adgroup_id, &b) }.
          to yield_with_args([
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000725744769',
              keyword: 'TEST-KEYWORD-04',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-20T10:36:41.000Z',
              edit_tm: '2017-07-20T10:36:41.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4}),
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000725744770',
              keyword: 'TEST-KEYWORD-05',
              customer_id: 1077530,
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              ncc_campaign_id: 'cmp-a001-01-000000000652963',
              user_lock: false,
              inspect_status: 'UNDER_REVIEW',
              bid_amt: 70,
              use_group_bid_amt: true,
              reg_tm: '2017-07-20T10:36:41.000Z',
              edit_tm: '2017-07-20T10:36:41.000Z',
              status: 'PAUSED',
              status_reason: 'KEYWORD_UNDER_REVIEW',
              ncc_qi: {'qi_grade'=>4})
          ], nil)
      end
    end

    context 'when creating an ad keyword with existing keyword' do
      let(:ad_keyword) { { 'keyword' => 'existing-keyword' } }

      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/keywords?nccAdgroupId=grp-a001-01-000000003865468').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "keyword":"EXISTING-KEYWORD",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":false,
    "inspectStatus":"UNDER_REVIEW",
    "bidAmt":70,
    "useGroupBidAmt":true,
    "resultStatus":{
      "code":3908,
      "message":"This keyword is already available."
    }
  }
]
JSON
          )
      end

      it 'should return result_status = 3908' do
       result = this.create_ad_keywords([ad_keyword], adgroup_id)
       expect(result[0].result_status['code']).to eq(3908)
      end
    end
  end

  describe '#update_ad_keyword' do
    context 'when all ok' do
      context 'with userLock field' do
        let(:ad_keyword) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744770',
            'userLock' => true
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000725744770?fields=userLock').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccKeywordId": "nkw-a001-01-000000725744770",
  "keyword": "TEST-KEYWORD-05",
  "customerId": 1077530,
  "nccAdgroupId": "grp-a001-01-000000003865468",
  "nccCampaignId": "cmp-a001-01-000000000652963",
  "userLock": true
}
JSON
           )
        end

        it 'should update userLock' do
          result = this.update_ad_keyword(ad_keyword, field: 'userLock')
          expect(result.user_lock).to eq(true)
        end
      end

      context 'with bidAmt field' do
        let(:ad_keyword) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744770',
            'bidAmt' => 110,
            'useGroupBidAmt' => true
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000725744770?fields=bidAmt').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccKeywordId": "nkw-a001-01-000000725744770",
  "keyword": "TEST-KEYWORD-05",
  "customerId": 1077530,
  "nccAdgroupId": "grp-a001-01-000000003865468",
  "nccCampaignId": "cmp-a001-01-000000000652963",
  "bidAmt":110,
  "useGroupBidAmt":true
}
JSON
           )
        end

        it 'should update bidAmt and useGroupBidAmt' do
          result = this.update_ad_keyword(ad_keyword, field: 'bidAmt')
          expect(result.bid_amt).to eq(110)
          expect(result.use_group_bid_amt).to eq(true)
        end
      end

      context 'with links field' do
        let(:ad_keyword) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744770',
            'links' => {
              'pc' => {
                'final' => 'https://forward3d.com'
              },
              'mobile' => {
                'final' => 'https://forward3d.com'
              }
            }
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000725744770?fields=links').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccKeywordId": "nkw-a001-01-000000725744770",
  "keyword": "TEST-KEYWORD-05",
  "customerId": 1077530,
  "nccAdgroupId": "grp-a001-01-000000003865468",
  "nccCampaignId": "cmp-a001-01-000000000652963",
  "links":{
    "pc":{
      "final":"https://forward3d.com",
      "punyCode":"https://forward3d.com"
    },
    "mobile":{
      "final":"https://forward3d.com",
      "punyCode":"https://forward3d.com"
    }
  }
}
JSON
           )
        end

        it 'should update links' do
          result = this.update_ad_keyword(ad_keyword, field: 'links')
          expect(result.links['pc']['final']).to eq('https://forward3d.com')
          expect(result.links['mobile']['final']).to eq('https://forward3d.com')
        end
      end

      context 'with inspect field' do
        let(:ad_keyword) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744770',
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000725744770?fields=inspect').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccKeywordId": "nkw-a001-01-000000725744770",
  "keyword": "TEST-KEYWORD-05",
  "customerId": 1077530,
  "nccAdgroupId": "grp-a001-01-000000003865468",
  "nccCampaignId": "cmp-a001-01-000000000652963",
  "inspectStatus": "PENDING"
}
JSON
           )
        end

        it 'should update status' do
          result = this.update_ad_keyword(ad_keyword, field: 'inspect')
          expect(result.inspect_status).to eq('PENDING')
        end
      end

      context 'without any specific field' do
        let(:ad_keyword) {
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744770',
            'userLock' => false,
            'bidAmt' => 120,
            'useGroupBidAmt' => true,
            'links' => {
              'pc' => {
                'final' => 'https://forward3d.com'
              },
              'mobile' => {
                'final' => 'https://forward3d.com'
              }
            }
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000725744770?fields=').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccKeywordId":"nkw-a001-01-000000725744770",
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "links":{
    "pc":{"final":"https://forward3d.com"},
    "mobile":{"final":"https://forward3d.com"}
  },
  "userLock":false,
  "bidAmt":120,
  "useGroupBidAmt":true
}
JSON
           )
        end

        it 'should update all given fields' do
          expect { |b| this.update_ad_keyword(ad_keyword, &b) }.
            to yield_with_args(
              OpenStruct.new(
                ncc_keyword_id: 'nkw-a001-01-000000725744770',
                ncc_adgroup_id: 'grp-a001-01-000000003865468',
                user_lock: false,
                bid_amt: 120,
                use_group_bid_amt: true,
                links: {
                  'pc'=>{
                    'final'=>'https://forward3d.com'
                  },
                  'mobile'=>{
                    'final'=>'https://forward3d.com'
                  }
                }
              ), nil)
        end
      end
    end

    context 'when required attribute is missing' do
      let(:ad_keyword) { { 'nccKeywordId' => 'nkw-a001-01-000000725744770' } }

      it { expect{ this.update_ad_keyword(ad_keyword) }.to raise_error(MissingRequiredAttributeError) }
    end
  end

  describe '#update_ad_keywords' do
    context 'when many keywords given with userLock field' do
      let(:ad_keywords) {
        [
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744769',
            'userLock' => true
          },
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744770',
            'userLock' => true
          }
        ]
      }
      before(:each) do
        stub_request(:put, 'https://api.naver.com/ncc/keywords?fields=userLock').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000725744770",
    "keyword":"TEST-KEYWORD-05",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":true
  },
  {
    "nccKeywordId":"nkw-a001-01-000000725744769",
    "keyword":"TEST-KEYWORD-04",
    "customerId":1077530,
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "nccCampaignId":"cmp-a001-01-000000000652963",
    "userLock":true
  }
]
JSON
          )
      end

      it 'should update given field in the keywords' do
        results = this.update_ad_keywords(ad_keywords, field: 'userLock')
        expect(results[0].user_lock).to eq(true)
        expect(results[1].user_lock).to eq(true)
      end
    end

    context 'when many keywords given without specific field' do
      let(:ad_keywords) {
        [
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744770',
            'userLock' => false,
            'bidAmt' => 130,
            'useGroupBidAmt' => true,
            'links' => {
              'pc' => {
                'final' => 'https://forward3d.com'
              },
              'mobile' => {
                'final' => 'https://forward3d.com'
              }
            }
          },
          {
            'nccAdgroupId' => 'grp-a001-01-000000003865468',
            'nccKeywordId' => 'nkw-a001-01-000000725744769',
            'userLock' => false,
            'bidAmt' => 130,
            'useGroupBidAmt' => true,
            'links' => {
              'pc' => {
                'final' => 'https://forward3d.com'
              },
              'mobile' => {
                'final' => 'https://forward3d.com'
              }
            }
          }
        ]
      }
      before(:each) do
        stub_request(:put, 'https://api.naver.com/ncc/keywords?fields=').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccKeywordId":"nkw-a001-01-000000725744770",
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "links":{
      "pc":{"final":"https://forward3d.com"},
      "mobile":{"final":"https://forward3d.com"}
    },
    "userLock":false,
    "bidAmt":130,
    "useGroupBidAmt":true
  },
  {
    "nccKeywordId":"nkw-a001-01-000000725744769",
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "links":{
      "pc":{"final":"https://forward3d.com"},
      "mobile":{"final":"https://forward3d.com"}
    },
    "userLock":false,
    "bidAmt":130,
    "useGroupBidAmt":true
  }
]
JSON
          )
      end

      it 'should update given field in the keywords' do
        expect { |b| this.update_ad_keywords(ad_keywords, &b) }.
          to yield_with_args([
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000725744770',
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              user_lock: false,
              links: {
                'pc'=>{
                  'final'=>'https://forward3d.com'
                },
                'mobile'=>{
                  'final'=>'https://forward3d.com'
                }
              },
              bid_amt: 130,
              use_group_bid_amt: true
              ),
            OpenStruct.new(
              ncc_keyword_id: 'nkw-a001-01-000000725744769',
              ncc_adgroup_id: 'grp-a001-01-000000003865468',
              user_lock: false,
              links: {
                'pc'=>{
                  'final'=>'https://forward3d.com'
                },
                'mobile'=>{
                  'final'=>'https://forward3d.com'
                }
              },
              bid_amt: 130,
              use_group_bid_amt: true
              )
          ], nil)
      end
    end
  end

  describe '#delete_ad_keyword' do
    context 'when all ok' do
      let(:ad_keyword_id) { 'nkw-a001-01-000000723631063' }

      before(:each) do
        stub_request(:delete, 'https://api.naver.com/ncc/keywords/nkw-a001-01-000000723631063').
          to_return(status: 204)
      end

      it 'should delete the given ad keyword' do
        expect { |b| this.delete_ad_keyword(ad_keyword_id, &b) }.to yield_with_args('', nil)
      end
    end
  end

  describe '#delete_ad_keywords' do
    context 'when all ok' do
      let(:ad_keyword_ids) { ['nkw-a001-01-000000725744769', 'nkw-a001-01-000000725744770'] }

      before(:each) do
        stub_request(:delete, 'https://api.naver.com/ncc/keywords?ids=nkw-a001-01-000000725744769,nkw-a001-01-000000725744770').
          to_return(status: 204)
      end

      it 'should delete the given ad keywords' do
        expect { |b| this.delete_ad_keywords(ad_keyword_ids, &b) }.to yield_with_args('', nil)
      end
    end
  end
end
