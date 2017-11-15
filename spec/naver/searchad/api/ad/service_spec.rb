require 'spec_helper'

include Naver::Searchad::Api

describe Ad::Service do
  subject(:this) { described_class.new }
  before(:each) do
    this.authorization = Auth.get_application_default
  end

  describe '#list_ads' do
    context 'when requesting some' do
      let(:ad_ids) { ['nad-a001-01-000000015970482', 'nad-a001-01-000000015970494'] }
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/ads?ids=nad-a001-01-000000015970482,nad-a001-01-000000015970494').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccAdId":"nad-a001-01-000000015970482",
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "customerId":1077530,
    "inspectStatus":"UNDER_REVIEW",
    "type":"TEXT_45",
    "ad":{
      "description":"This is a testing ad 00",
      "headline":"test-ad-00",
      "mobile":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      },
      "pc":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      }
    },
    "adAttr":{},
    "userLock":false,
    "enable":true,
    "delFlag":false,
    "regTm":"2017-07-20T14:00:17.000Z",
    "editTm":"2017-07-20T14:00:17.000Z",
    "status":"PAUSED",
    "statusReason":"AD_UNDER_REVIEW"
  },
  {
    "nccAdId":"nad-a001-01-000000015970494",
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "customerId":1077530,
    "inspectStatus":"UNDER_REVIEW",
    "type":"TEXT_45",
    "ad":{
      "description":"This is a testing ad 01",
      "headline":"test-ad-01",
      "mobile":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      },
      "pc":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      }
    },
    "adAttr":{},
    "userLock":false,
    "enable":true,
    "delFlag":false,
    "regTm":"2017-07-20T14:03:29.000Z",
    "editTm":"2017-07-20T14:03:29.000Z",
    "status":"PAUSED",
    "statusReason":"AD_UNDER_REVIEW"
  }
]
JSON
          )
      end

      it 'should return requested ads' do
        expect { |b| this.list_ads(ad_ids, &b) }.to yield_with_args([
          OpenStruct.new(
            ncc_ad_id: 'nad-a001-01-000000015970482',
            ncc_adgroup_id: 'grp-a001-01-000000003865468',
            customer_id: 1077530,
            inspect_status: 'UNDER_REVIEW',
            type: 'TEXT_45',
            ad: {
              'description'=>'This is a testing ad 00',
              'headline'=>'test-ad-00',
              'mobile'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              },
              'pc'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              }
            },
            ad_attr: {},
            user_lock: false,
            enable: true,
            del_flag: false,
            reg_tm: '2017-07-20T14:00:17.000Z',
            edit_tm: '2017-07-20T14:00:17.000Z',
            status: 'PAUSED',
            status_reason: 'AD_UNDER_REVIEW'
            ),
          OpenStruct.new(
            ncc_ad_id: 'nad-a001-01-000000015970494',
            ncc_adgroup_id: 'grp-a001-01-000000003865468',
            customer_id: 1077530,
            inspect_status: 'UNDER_REVIEW',
            type: 'TEXT_45',
            ad: {
              'description'=>'This is a testing ad 01',
              'headline'=>'test-ad-01',
              'mobile'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              },
              'pc'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              }
            },
            ad_attr: {},
            user_lock: false,
            enable: true,
            del_flag: false,
            reg_tm: '2017-07-20T14:03:29.000Z',
            edit_tm: '2017-07-20T14:03:29.000Z',
            status: 'PAUSED',
            status_reason: 'AD_UNDER_REVIEW'
            )
        ], nil)
      end
    end
  end

  describe '#list_ads_by_adgroup_id' do
    context 'when all ok' do
      let(:adgroup_id) { 'grp-a001-01-000000003865468' }
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/ads?nccAdgroupId=grp-a001-01-000000003865468').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccAdId":"nad-a001-01-000000015970494",
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "customerId":1077530,
    "inspectStatus":"UNDER_REVIEW",
    "type":"TEXT_45",
    "ad":{
      "description":"This is a testing ad 01",
      "headline":"test-ad-01",
      "mobile":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      },
      "pc":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      }
    },
    "adAttr":{},
    "userLock":false,
    "enable":true,
    "delFlag":false,
    "regTm":"2017-07-20T14:03:29.000Z",
    "editTm":"2017-07-20T14:03:29.000Z",
    "status":"PAUSED",
    "statusReason":"AD_UNDER_REVIEW"
  },
  {
    "nccAdId":"nad-a001-01-000000015970482",
    "nccAdgroupId":"grp-a001-01-000000003865468",
    "customerId":1077530,
    "inspectStatus":"UNDER_REVIEW",
    "type":"TEXT_45",
    "ad":{
      "description":"This is a testing ad 00",
      "headline":"test-ad-00",
      "mobile":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      },
      "pc":{
        "display":"http://www.mymemodel.com",
        "final":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      }
    },
    "adAttr":{},
    "userLock":false,
    "enable":true,
    "delFlag":false,
    "regTm":"2017-07-20T14:00:17.000Z",
    "editTm":"2017-07-20T14:00:17.000Z",
    "status":"PAUSED",
    "statusReason":"AD_UNDER_REVIEW"
  }
]
JSON
          )
      end

      it 'should return an array of relevant ads' do
        expect { |b| this.list_ads_by_adgroup_id(adgroup_id, &b) }.to yield_with_args([
          OpenStruct.new(
            ncc_ad_id: 'nad-a001-01-000000015970494',
            ncc_adgroup_id: 'grp-a001-01-000000003865468',
            customer_id: 1077530,
            inspect_status: 'UNDER_REVIEW',
            type: 'TEXT_45',
            ad: {
              'description'=>'This is a testing ad 01',
              'headline'=>'test-ad-01',
              'mobile'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              },
              'pc'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              }
            },
            ad_attr: {},
            user_lock: false,
            enable: true,
            del_flag: false,
            reg_tm: '2017-07-20T14:03:29.000Z',
            edit_tm: '2017-07-20T14:03:29.000Z',
            status: 'PAUSED',
            status_reason: 'AD_UNDER_REVIEW'
            ),
          OpenStruct.new(
            ncc_ad_id: 'nad-a001-01-000000015970482',
            ncc_adgroup_id: 'grp-a001-01-000000003865468',
            customer_id: 1077530,
            inspect_status: 'UNDER_REVIEW',
            type: 'TEXT_45',
            ad: {
              'description'=>'This is a testing ad 00',
              'headline'=>'test-ad-00',
              'mobile'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              },
              'pc'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              }
            },
            ad_attr: {},
            user_lock: false,
            enable: true,
            del_flag: false,
            reg_tm: '2017-07-20T14:00:17.000Z',
            edit_tm: '2017-07-20T14:00:17.000Z',
            status: 'PAUSED',
            status_reason: 'AD_UNDER_REVIEW'
            )
        ], nil)
      end
    end
  end

  describe '#get_ad' do
    context 'when all ok' do
      let(:ad_id) { 'nad-a001-01-000000015970482' }
      before(:each) do
        stub_request(:get, 'https://api.naver.com/ncc/ads/nad-a001-01-000000015970482').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccAdId":"nad-a001-01-000000015970482",
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "inspectStatus":"UNDER_REVIEW",
  "type":"TEXT_45",
  "ad":{
    "description":"This is a testing ad 00",
    "headline":"test-ad-00",
    "mobile":{
      "display":"http://www.mymemodel.com",
      "final":"http://www.mymemodel.com",
      "punyCode":"http://www.mymemodel.com"
    },
    "pc":{
      "display":"http://www.mymemodel.com",
      "final":"http://www.mymemodel.com",
      "punyCode":"http://www.mymemodel.com"
    }
  },
  "adAttr":{},
  "userLock":false,
  "enable":true,
  "referenceData":{
    "reviewCountSum":0,
    "purchaseCnt":0,
    "keepCnt":0
  },
  "delFlag":false,
  "regTm":"2017-07-20T14:00:17.000Z",
  "editTm":"2017-07-20T14:00:17.000Z",
  "status":"PAUSED",
  "statusReason":"AD_UNDER_REVIEW"
}
JSON
          )
      end

      it 'should return relevant ad' do
        expect { |b| this.get_ad(ad_id, &b) }.to yield_with_args(
          OpenStruct.new(
            ncc_ad_id: 'nad-a001-01-000000015970482',
            ncc_adgroup_id: 'grp-a001-01-000000003865468',
            customer_id: 1077530,
            inspect_status: 'UNDER_REVIEW',
            type: 'TEXT_45',
            ad: {
              'description'=>'This is a testing ad 00',
              'headline'=>'test-ad-00',
              'mobile'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              },
              'pc'=>{
                'display'=>'http://www.mymemodel.com',
                'final'=>'http://www.mymemodel.com',
                'puny_code'=>'http://www.mymemodel.com'
              }
            },
            ad_attr: {},
            user_lock: false,
            enable: true,
            reference_data: {
              'review_count_sum'=>0,
              'purchase_cnt'=>0,
              'keep_cnt'=>0
            },
            del_flag: false,
            reg_tm: '2017-07-20T14:00:17.000Z',
            edit_tm: '2017-07-20T14:00:17.000Z',
            status: 'PAUSED',
            status_reason: 'AD_UNDER_REVIEW'
            ), nil)
      end
    end
  end

  describe '#create_ad' do
    context 'when creating with only required attributes' do
      let(:ad) {
        {
          'nccAdgroupId' => 'grp-a001-01-000000003865468',
          'type' => 'TEXT_45',
          'ad' => {
            'pc' => {
              'final' => 'http://forward3d.com'
            },
            'mobile' => {
              'final' => 'http://forward3d.com'
            },
            'headline' => 'testing ad 03',
            'description' => 'this is a testing ad 03 and description'
          }
        }
      }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/ads').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccAdId":"nad-a001-01-000000015971634",
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "inspectStatus":"UNDER_REVIEW",
  "type":"TEXT_45",
  "ad":{
    "description":"this is a testing ad 03 and description",
    "headline":"testing ad 03",
    "mobile":{
      "final":"http://forward3d.com",
      "display":"http://www.mymemodel.com",
      "punyCode":"http://forward3d.com"
    },
    "pc":{
      "final":"http://forward3d.com",
      "display":"http://www.mymemodel.com",
      "punyCode":"http://forward3d.com"
    }
  },
  "adAttr":{},
  "userLock":false,
  "enable":true,
  "delFlag":false,
  "regTm":"2017-07-20T14:43:34.000Z",
  "editTm":"2017-07-20T14:43:34.000Z",
  "status":"PAUSED",
  "statusReason":"AD_UNDER_REVIEW"
}
JSON
          )
      end

      it 'should create one filled with default values' do
        expect { |b| this.create_ad(ad, &b) }.to yield_with_args(
          OpenStruct.new(
            ncc_ad_id: 'nad-a001-01-000000015971634',
            ncc_adgroup_id: 'grp-a001-01-000000003865468',
            customer_id: 1077530,
            inspect_status: 'UNDER_REVIEW',
            type: 'TEXT_45',
            ad: {
              'description'=>'this is a testing ad 03 and description',
              'headline'=>'testing ad 03',
              'mobile'=>{
                'final'=>'http://forward3d.com',
                'display'=>'http://www.mymemodel.com',
                'puny_code'=>'http://forward3d.com'
              },
              'pc'=>{
                'final'=>'http://forward3d.com',
                'display'=>'http://www.mymemodel.com',
                'puny_code'=>'http://forward3d.com'
              }
            },
            ad_attr: {},
            user_lock: false,
            enable: true,
            del_flag: false,
            reg_tm: '2017-07-20T14:43:34.000Z',
            edit_tm: '2017-07-20T14:43:34.000Z',
            status: 'PAUSED',
            status_reason: 'AD_UNDER_REVIEW'
          ), nil
        )
      end
    end

    context 'when creating with all attributes' do
      let(:ad) {
        {
          'nccAdgroupId' => 'grp-a001-01-000000003865468',
          'type' => 'TEXT_45',
          'ad' => {
            'pc' => {
              'final' => 'http://forward3d.com'
            },
            'mobile' => {
              'final' => 'http://forward3d.com'
            },
            'headline' => 'testing ad 04',
            'description' => 'this is a testing ad 04 and description'
          },
          'userLock' => true,
          'inspectRequestMsg' => 'please, ignore me. this is a testing request'
        }
      }
      before(:each) do
        stub_request(:post, 'https://api.naver.com/ncc/ads').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
{
  "nccAdId":"nad-a001-01-000000015971701",
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "inspectStatus":"UNDER_REVIEW",
  "type":"TEXT_45",
  "ad":{
    "description":"this is a testing ad 04 and description",
    "headline":"testing ad 04",
    "mobile":{
      "final":"http://forward3d.com",
      "display":"http://www.mymemodel.com",
      "punyCode":"http://forward3d.com"
    },
    "pc":{
      "final":"http://forward3d.com",
      "display":"http://www.mymemodel.com",
      "punyCode":"http://forward3d.com"
    }
  },
  "adAttr":{},
  "userLock":true,
  "enable":true,
  "delFlag":false,
  "regTm":"2017-07-20T14:48:11.000Z",
  "editTm":"2017-07-20T14:48:11.000Z",
  "status":"PAUSED",
  "statusReason":"AD_UNDER_REVIEW"
}
JSON
          )
      end

      it 'should create one filled with given values' do
        expect { |b| this.create_ad(ad, &b) }.to yield_with_args(
          OpenStruct.new(
            ncc_ad_id: 'nad-a001-01-000000015971701',
            ncc_adgroup_id: 'grp-a001-01-000000003865468',
            customer_id: 1077530,
            inspect_status: 'UNDER_REVIEW',
            type: 'TEXT_45',
            ad: {
              'description'=>'this is a testing ad 04 and description',
              'headline'=>'testing ad 04',
              'mobile'=>{
                'final'=>'http://forward3d.com',
                'display'=>'http://www.mymemodel.com',
                'puny_code'=>'http://forward3d.com'
              },
              'pc'=>{
                'final'=>'http://forward3d.com',
                'display'=>'http://www.mymemodel.com',
                'puny_code'=>'http://forward3d.com'
              }
            },
            ad_attr: {},
            user_lock: true,
            enable: true,
            del_flag: false,
            reg_tm: '2017-07-20T14:48:11.000Z',
            edit_tm: '2017-07-20T14:48:11.000Z',
            status: 'PAUSED',
            status_reason: 'AD_UNDER_REVIEW'
          ), nil
        )
      end
    end

    context 'when missing required attribute in request object' do
      let(:ad) { { } }

      it { expect{ this.create_ad(ad) }.to raise_error(MissingRequiredAttributeError) }
    end
  end

  describe '#update_ad' do
    context 'when all ok' do
      context 'with userLock field' do
        let(:ad) {
          {
            'nccAdId' => 'nad-a001-01-000000015971701',
            'userLock' => true
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/ads/nad-a001-01-000000015971701?fields=userLock').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdId":"nad-a001-01-000000015971701",
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "userLock":true
}
JSON
          )
        end

        it 'should update userLock' do
          result = this.update_ad(ad, field: 'userLock')
          expect(result.user_lock).to eq(true)
        end
      end

      context 'with inspect field' do
        let(:ad) {
          {
            'nccAdId' => 'nad-a001-01-000000015971701',
            'inspectRequestMsg' => 'this is a inspect request message'
          }
        }
        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/ads/nad-a001-01-000000015971701?fields=inspect').
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
{
  "nccAdId":"nad-a001-01-000000015971701",
  "nccAdgroupId":"grp-a001-01-000000003865468",
  "customerId":1077530,
  "inspectStatus":"PENDING"
}
JSON
          )
      end

        it 'should update status' do
          result = this.update_ad(ad, field: 'inspect')
          expect(result.inspect_status).to eq('PENDING')
        end
      end

      context 'without any specific field' do
        let(:ad) {
          {
            'nccAdId' => 'nad-a001-01-000000015971701',
            'userLock' => false,
            'inspectRequestMsg' => ''
          }
        }

        before(:each) do
          stub_request(:put, 'https://api.naver.com/ncc/ads/nad-a001-01-000000015971701?fields=').
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

        let(:request) { this.update_ad(ad) }

        it_behaves_like 'invalid request'
      end
    end

    context 'when required attribute is missing' do
      let(:ad) { { } }

      it { expect{ this.update_ad(ad) }.to raise_error(MissingRequiredAttributeError) }
    end
  end

  describe '#delete_ad' do
    context 'when all ok' do
      let(:ad_id) { 'nad-a001-01-000000015971701' }

      before(:each) do
        stub_request(:delete, 'https://api.naver.com/ncc/ads/nad-a001-01-000000015971701').
          to_return(status: 204)
      end

      it 'should delete the given ad' do
        expect { |b| this.delete_ad(ad_id, &b) }.to yield_with_args('', nil)
      end
    end
  end

  describe '#copy_ads' do
    context 'when all ok' do
      let(:ad_ids) { ['nad-a001-01-000000015970482', 'nad-a001-01-000000015970494'] }
      let(:target_ad_group_id) { 'grp-a001-01-000000003864948' }

      before(:each) do
        stub_request(:put, 'https://api.naver.com/ncc/ads?ids=nad-a001-01-000000015970482,nad-a001-01-000000015970494&targetAdgroupId=grp-a001-01-000000003864948&userLock=true').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
[
  {
    "nccAdId":"nad-a001-01-000000015971865",
    "nccAdgroupId":"grp-a001-01-000000003864948",
    "customerId":1077530,
    "inspectStatus":"UNDER_REVIEW",
    "type":"TEXT_45",
    "ad":{
      "description":"This is a testing ad 00",
      "headline":"test-ad-00",
      "mobile":{
        "final":"http://www.mymemodel.com",
        "display":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      },
      "pc":{
        "final":"http://www.mymemodel.com",
        "display":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      }
    },
    "adAttr":{},
    "userLock":true,
    "enable":true,
    "preNccAdId":"nad-a001-01-000000015970482",
    "delFlag":false,
    "regTm":"2017-07-20T15:25:14.000Z",
    "editTm":"2017-07-20T15:25:14.000Z",
    "status":"PAUSED",
    "statusReason":"AD_UNDER_REVIEW"
  },
  {
    "nccAdId":"nad-a001-01-000000015971866",
    "nccAdgroupId":"grp-a001-01-000000003864948",
    "customerId":1077530,
    "inspectStatus":"UNDER_REVIEW",
    "type":"TEXT_45",
    "ad":{
      "description":"This is a testing ad 01",
      "headline":"test-ad-01",
      "mobile":{
        "final":"http://www.mymemodel.com",
        "display":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      },
      "pc":{
        "final":"http://www.mymemodel.com",
        "display":"http://www.mymemodel.com",
        "punyCode":"http://www.mymemodel.com"
      }
    },
    "adAttr":{},
    "userLock":true,
    "enable":true,
    "preNccAdId":"nad-a001-01-000000015970494",
    "delFlag":false,
    "regTm":"2017-07-20T15:25:14.000Z",
    "editTm":"2017-07-20T15:25:14.000Z",
    "status":"PAUSED",
    "statusReason":"AD_UNDER_REVIEW"
  }
]
JSON
          )
      end

      it 'should copy the given ads to the target group' do
        expect { |b| this.copy_ads(ad_ids, target_ad_group_id, true, &b) }.
          to yield_with_args(
            [
              OpenStruct.new(
                ncc_ad_id: 'nad-a001-01-000000015971865',
                ncc_adgroup_id: 'grp-a001-01-000000003864948',
                customer_id: 1077530,
                inspect_status: 'UNDER_REVIEW',
                type: 'TEXT_45',
                ad: {
                  'description'=>'This is a testing ad 00',
                  'headline'=>'test-ad-00',
                  'mobile'=>{
                    'final'=>'http://www.mymemodel.com',
                    'display'=>'http://www.mymemodel.com',
                    'puny_code'=>'http://www.mymemodel.com'
                  },
                  'pc'=>{
                    'final'=>'http://www.mymemodel.com',
                    'display'=>'http://www.mymemodel.com',
                    'puny_code'=>'http://www.mymemodel.com'
                  }
                },
                ad_attr: {},
                user_lock: true,
                enable: true,
                pre_ncc_ad_id: 'nad-a001-01-000000015970482',
                del_flag: false,
                reg_tm: '2017-07-20T15:25:14.000Z',
                edit_tm: '2017-07-20T15:25:14.000Z',
                status: 'PAUSED',
                status_reason: 'AD_UNDER_REVIEW'
                ),
              OpenStruct.new(
                ncc_ad_id: 'nad-a001-01-000000015971866',
                ncc_adgroup_id: 'grp-a001-01-000000003864948',
                customer_id: 1077530,
                inspect_status: 'UNDER_REVIEW',
                type: 'TEXT_45',
                ad: {
                  'description'=>'This is a testing ad 01',
                  'headline'=>'test-ad-01',
                  'mobile'=>{
                    'final'=>'http://www.mymemodel.com',
                    'display'=>'http://www.mymemodel.com',
                    'puny_code'=>'http://www.mymemodel.com'
                  },
                  'pc'=>{
                    'final'=>'http://www.mymemodel.com',
                    'display'=>'http://www.mymemodel.com',
                    'puny_code'=>'http://www.mymemodel.com'
                  }
                },
                ad_attr: {},
                user_lock: true,
                enable: true,
                pre_ncc_ad_id: 'nad-a001-01-000000015970494',
                del_flag: false,
                reg_tm: '2017-07-20T15:25:14.000Z',
                edit_tm: '2017-07-20T15:25:14.000Z',
                status: 'PAUSED',
                status_reason: 'AD_UNDER_REVIEW'
                )
            ], nil)
      end
    end
  end
end
