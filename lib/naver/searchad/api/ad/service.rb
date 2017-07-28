require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Ad
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/')
          end

          def list(ad_ids, options: nil, &block)
            command = make_command(:get, 'ads', options)
            command.query['ids'] = ad_ids.join(',')
            execute_command(command, &block)
          end

          def list_by_adgroup_id(adgroup_id, options: nil, &block)
            command = make_command(:get, 'ads', options)
            command.query['nccAdgroupId'] = adgroup_id
            execute_command(command, &block)
          end

          def get_ad(ad_id, options: nil, &block)
            command = make_command(:get, 'ads/{ad_id}', options)
            command.params['ad_id'] = ad_id
            execute_command(command, &block)
          end

          def create_ad(ad, options: nil, &block)
            validates_presence_of(%w[ad nccAdgroupId type], ad)

            command = make_command(:post, 'ads', options)
            command.request_object = ad
            execute_command(command, &block)
          end

          def update_ad(ad, field: '', options: nil, &block)
            validates_presence_of(%w[nccAdId adAttr], ad)

            command = make_command(:put, 'ads/{ad_id}', options)
            command.params['ad_id'] = ad['nccAdId']
            command.query['fields'] = field
            command.request_object = ad
            execute_command(command, &block)
          end

          def delete_ad(ad_id, options: nil, &block)
            command = make_command(:delete, 'ads/{ad_id}', options)
            command.params['ad_id'] = ad_id
            execute_command(command, &block)
          end

          def copy_ads(ad_ids, target_ad_group_id, user_lock, options: nil, &block)
            command = make_command(:put, 'ads', options)
            command.query['ids'] = ad_ids.join(',')
            command.query['targetAdgroupId'] = target_ad_group_id
            command.query['userLock'] = user_lock
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
