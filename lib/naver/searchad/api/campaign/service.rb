require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Campaign
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/')
          end

          def create_campaign(campaign, options, &block)
            command = make_command(:post, 'campaigns', options)
            %w[campaignTp name customerId].each do |key|
              #raise MissingRequiredAttributeError.new(
              #  "Require #{key} attribute in campaign object") unless campaign.key?(key)
            end

            command.request_object = campaign
            execute_command(command, &block)
          end

          def list_campaigns_by_ids(campaign_ids, &block)
            command = make_command(:get, options, 'campaigns/')
            command.query['ids'] = campaign_ids.join(',')
            execute_command(command, &block)
          end

          def get_campaign(campaign_id, &block)
            command = make_command(:get, options, 'campaigns/{campaign_id}')
            command.params['campaign_id'] = campaign_id
            execute_command(command, &block)
          end

          def update_campaign(campaign, field, &block)
            command = make_command(:put, options, 'campaigns/{campaign_id}')
            command.query['fields'] = field
            command.params['campaign_id'] = campaign_id
            command.request_object = campaign
            execute_command(command, &block)
          end

          def delete_campaign(campaign_id, &block)
            command = make_command(:delete, options, 'campaigns/{campaign_id}')
            command.params['campaign_id'] = campaign_id
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
