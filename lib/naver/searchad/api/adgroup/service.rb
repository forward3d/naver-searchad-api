require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Adgroup
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/')
          end

          def list_adgroups_by_ids(adgroup_ids, options: nil, &block)
            command = make_command(:get, 'adgroups', options)
            command.query['ids'] = adgroup_ids.join(',')
            execute_command(command, &block)
          end

          def list_adgroups_by_campaign_id(campaign_id, options: nil, &block)
            command = make_command(:get, 'adgroups', options)
            command.query['nccCampaignId'] = campaign_id
            execute_command(command, &block)
          end

          def list_adgroups_by_label_id(label_id, options: nil, &block)
            command = make_command(:get, 'adgroups', options)
            command.query['nccLabelId'] = label_id
            execute_command(command, &block)
          end

          def get_adgroup(adgroup_id, options: nil, &block)
            command = make_command(:get, 'adgroups/{adgroup_id}', options)
            command.params['adgroup_id'] = adgroup_id
            execute_command(command, &block)
          end

          def create_adgroup(adgroup, options: nil, &block)
            validates_presence_of(%w[nccCampaignId pcChannelId mobileChannelId name], adgroup)

            command = make_command(:post, 'adgroups', options)
            command.request_object = adgroup
            execute_command(command, &block)
          end

          def update_adgroup(adgroup, field: nil, options: nil, &block)
            validates_presence_of(%w[nccAdgroupId], adgroup)

            command = make_command(:put, 'adgroups/{adgroup_id}', options)
            command.params['adgroup_id'] = adgroup['nccAdgroupId']
            command.query['fields'] = field if field
            command.request_object = adgroup
            execute_command(command, &block)
          end

          def delete_adgroup(adgroup_id, options: nil, &block)
            command = make_command(:delete, 'adgroups/{adgroup_id}', options)
            command.params['adgroup_id'] = adgroup_id
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
