require 'spec_helper'

include Naver::Searchad::Api

describe Bizmoney::Service do
  subject(:this) { described_class.new }
  before(:each) do
    this.authorization = Auth.get_application_default
  end

  describe '#get_bizmoney' do
    context 'when requesting bizmoney' do
      before(:each) do
        stub_request(:get, 'https://api.searchad.naver.com/billing/bizmoney').
          to_return(
            status: 200,
            headers: {'Content-Type' => 'application/json;charset=UTF-8'},
            body: <<-JSON
            {
              "bizmoney": 4735542,
              "budgetLock": false,
              "customerId": 660606,
              "refundLock": false
            }
            JSON
          )
      end

      it 'should return an relevant Bizmoney item' do
        expect { |b| this.get_bizmoney(&b) }.
          to yield_with_args(
            OpenStruct.new(
              bizmoney: 4735542,
              budget_lock: false,
              customer_id: 660606,
              refund_lock: false,
            ),
            nil)
      end
    end


    describe '#get_bizmoney_cost' do
      context 'when requesting bizmoney_cost' do
        let(:start_date) { Date.parse('2019-03-01') }

        before(:each) do
          stub_request(:get, "https://api.searchad.naver.com/billing/bizmoney/cost?searchEndDt=20190302&searchStartDt=20190301").
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
              [
                  {
                      "customerId": 660606,
                      "date": "2019-03-01T15:00:00.000Z",
                      "device": "MOBILE",
                      "networkType": "NAVER",
                      "nonRefundableAmt": 0,
                      "productCode": "CC_WEB",
                      "refundableAmt": 1089
                  },
                  {
                      "customerId": 660606,
                      "date": "2019-03-01T15:00:00.000Z",
                      "device": "PC",
                      "networkType": "NAVER",
                      "nonRefundableAmt": 0,
                      "productCode": "CC_WEB",
                      "refundableAmt": 99
                  }
              ]
              JSON
            )
        end

        it 'should return an array of relevant bizmoney items' do
          expect { |b| this.get_bizmoney_cost(start_date, start_date + 1, &b) }.
            to yield_with_args([
              OpenStruct.new(
                customer_id: 660606,
                date: "2019-03-01T15:00:00.000Z",
                device: "MOBILE",
                network_type: "NAVER",
                non_refundable_amt: 0,
                product_code: "CC_WEB",
                refundable_amt: 1089
              ),
              OpenStruct.new(
                customer_id: 660606,
                date: "2019-03-01T15:00:00.000Z",
                device: "PC",
                network_type: "NAVER",
                non_refundable_amt: 0,
                product_code: "CC_WEB",
                refundable_amt: 99
              )
            ], nil)
        end
      end
    end

    describe '#get_bizmoney_charge' do
      context 'when requesting bizmoney_charge' do
        let(:start_date) { Date.parse('2019-03-01') }

        before(:each) do
          stub_request(:get, "https://api.searchad.naver.com/billing/bizmoney/histories/charge?searchEndDt=20190302&searchStartDt=20190301").
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
              [
                  {
                      "displayCd": 1,
                      "displayName": "Charge Type Description(Korean)",
                      "newNonRefundableAmt": 0,
                      "newRefundableAmt": 540,
                      "statDt": 1552416
                  },
                  {
                      "displayCd": 2,
                      "displayName": "Charge Type Description(Korean)",
                      "newNonRefundableAmt": 0,
                      "newRefundableAmt": 120,
                      "statDt": 1549413
                  }
              ]
              JSON
            )
        end

        it 'should return an array of relevant bizmoney items' do
          expect { |b| this.get_bizmoney_charge(start_date, start_date + 1, &b) }.
            to yield_with_args([
              OpenStruct.new(
                display_cd: 1,
                display_name: "Charge Type Description(Korean)",
                new_non_refundable_amt: 0,
                new_refundable_amt: 540,
                stat_dt: 1552416
              ),
              OpenStruct.new(
                display_cd: 2,
                display_name: "Charge Type Description(Korean)",
                new_non_refundable_amt: 0,
                new_refundable_amt: 120,
                stat_dt: 1549413
              )
            ], nil)
        end
      end
    end

    describe '#get_bizmoney_exhaust' do
      context 'when requesting bizmoney_exhaust' do
        let(:start_date) { Date.parse('2019-03-01') }

        before(:each) do
          stub_request(:get, "https://api.searchad.naver.com/billing/bizmoney/histories/exhaust?searchEndDt=20190302&searchStartDt=20190301").
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
              [
                  {
                      "activityCd": 0,
                      "campaignTp": 1,
                      "customerId": 660606,
                      "prodInfoCd": "NCC",
                      "settleDt": 1551884400000,
                      "useNonrefundableAmt": 0,
                      "useRefundableAmt": -5687
                  },
                  {
                      "activityCd": 0,
                      "campaignTp": 1,
                      "customerId": 660606,
                      "prodInfoCd": "NCC",
                      "settleDt": 1551452400000,
                      "useNonrefundableAmt": 0,
                      "useRefundableAmt": -1188
                  }
              ]
              JSON
            )
        end

        it 'should return an array of relevant bizmoney items' do
          expect { |b| this.get_bizmoney_exhaust(start_date, start_date + 1, &b) }.
            to yield_with_args([
              OpenStruct.new(
                activity_cd: 0,
                campaign_tp: 1,
                customer_id: 660606,
                prod_info_cd: "NCC",
                settle_dt: 1551884400000,
                use_nonrefundable_amt: 0,
                use_refundable_amt: -5687
              ),
              OpenStruct.new(
                activity_cd: 0,
                campaign_tp: 1,
                customer_id: 660606,
                prod_info_cd: "NCC",
                settle_dt: 1551452400000,
                use_nonrefundable_amt: 0,
                use_refundable_amt: -1188
              )
            ], nil)
        end
      end
    end

    describe '#get_bizmoney_period' do
      context 'when requesting bizmoney_period' do
        let(:start_date) { Date.parse('2019-03-01') }

        before(:each) do
          stub_request(:get, "https://api.searchad.naver.com/billing/bizmoney/histories/period?searchEndDt=20190302&searchStartDt=20190301").
            to_return(
              status: 200,
              headers: {'Content-Type' => 'application/json;charset=UTF-8'},
              body: <<-JSON
              [
                  {
                      "addNonRefundableAmt": 0,
                      "addRefundableAmt": 0,
                      "customerId": 660606,
                      "nonRefundableAmt": 0,
                      "refundNonRefundableAmt": 0,
                      "refundRefundableAmt": 0,
                      "refundableAmt": 4736368,
                      "returnRefundableAmt": 0,
                      "settleDt": 1551452400000,
                      "useNonRefundableAmt": 0,
                      "useRefundableAmt": 1188
                  },
                  {
                      "addNonRefundableAmt": 0,
                      "addRefundableAmt": 0,
                      "customerId": 660606,
                      "nonRefundableAmt": 0,
                      "refundNonRefundableAmt": 0,
                      "refundRefundableAmt": 0,
                      "refundableAmt": 4735202,
                      "returnRefundableAmt": 0,
                      "settleDt": 1551538800000,
                      "useNonRefundableAmt": 0,
                      "useRefundableAmt": 1166
                  }
              ]
              JSON
            )
        end

        it 'should return an array of relevant bizmoney items' do
          expect { |b| this.get_bizmoney_period(start_date, start_date + 1, &b) }.
            to yield_with_args([
              OpenStruct.new(
                add_non_refundable_amt: 0,
                add_refundable_amt: 0,
                customer_id: 660606,
                non_refundable_amt: 0,
                refund_non_refundable_amt: 0,
                refund_refundable_amt: 0,
                refundable_amt: 4736368,
                return_refundable_amt: 0,
                settle_dt: 1551452400000,
                use_non_refundable_amt: 0,
                use_refundable_amt: 1188
              ),
              OpenStruct.new(
                add_non_refundable_amt: 0,
                add_refundable_amt: 0,
                customer_id: 660606,
                non_refundable_amt: 0,
                refund_non_refundable_amt: 0,
                refund_refundable_amt: 0,
                refundable_amt: 4735202,
                return_refundable_amt: 0,
                settle_dt: 1551538800000,
                use_non_refundable_amt: 0,
                use_refundable_amt: 1166
              )
            ], nil)
        end
      end
    end

  end

end
