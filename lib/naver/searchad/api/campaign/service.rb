module Naver
  module Searchad
    module Api
      module Campaign
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/campaigns/')
          end

          def list_campaigns_by_ids(campaign_ids, &block)

          end

          def get_campaign(campaign_id, &block)

          end

          def create_campaign(campaign, &block)

          end

          def update_campaign(campaign, fields, &block)

          end

          def delete_campaign(campaign_id, &block)

          end
        end
      end
    end
  end
end
