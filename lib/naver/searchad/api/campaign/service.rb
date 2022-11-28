require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Campaign
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.searchad.naver.com/', 'ncc/')
          end

          def list_campaigns(options: nil, &block)
            command = make_command(:get, 'campaigns', options)
            execute_command(command, &block)
          end

          def list_campaigns_by_ids(campaign_ids, options: nil, &block)
            command = make_command(:get, 'campaigns/', options)
            command.query['ids'] = campaign_ids.join(',')
            execute_command(command, &block)
          end

          def get_campaign(campaign_id, options: nil, &block)
            command = make_command(:get, 'campaigns/{campaign_id}', options)
            command.params['campaign_id'] = campaign_id
            execute_command(command, &block)
          end

          def create_campaign(campaign, options: nil, &block)
            validates_presence_of(%w[campaignTp name customerId], campaign)

            command = make_command(:post, 'campaigns', options)
            command.request_object = campaign
            execute_command(command, &block)
          end

          def update_campaign(campaign, field: nil, options: nil, &block)
            validates_presence_of(%w[nccCampaignId], campaign)

            command = make_command(:put, 'campaigns/{campaign_id}', options)
            command.params['campaign_id'] = campaign['nccCampaignId']
            command.query['fields'] = field if field
            command.request_object = campaign
            execute_command(command, &block)
          end

          def delete_campaign(campaign_id, options: nil, &block)
            command = make_command(:delete, 'campaigns/{campaign_id}', options)
            command.params['campaign_id'] = campaign_id
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
