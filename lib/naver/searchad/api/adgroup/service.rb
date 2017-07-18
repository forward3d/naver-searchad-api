module Naver
  module Searchad
    module Api
      module Adgroup
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/adgroups/')
          end

          def list_adgroups_by_ids(adgroup_ids, options: nil, &block)

          end

          def list_adgroups_by_campaign_id(campaign_id, options: nil, &block)

          end

          def list_adgroups_by_label_id(label_id, options: nil, &block)

          end

          def get_adgroup(adgroup_id, options: nil, &block)

          end

          def create_adgroup(adgroup, options: nil, &block)

          end

          def update_adgroup(adgroup, fields, options: nil, &block)

          end

          def delete_adgroup(adgroup_id, options: nil, &block)

          end
        end
      end
    end
  end
end
