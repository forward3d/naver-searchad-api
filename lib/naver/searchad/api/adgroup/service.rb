module Naver
  module Searchad
    module Api
      module Adgroup
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/adgroups/')
          end

          def list_adgroups_by_ids(adgroup_ids, &block)

          end

          def list_adgroups_by_campaign_id(campaign_id, &block)

          end

          def list_adgroups_by_label_id(label_id, &block)

          end

          def get_adgroup(adgroup_id, &block)

          end

          def create_adgroup(adgroup, &block)

          end

          def update_adgroup(adgroup, fields, &block)

          end

          def delete_adgroup(adgroup_id, &block)

          end
        end
      end
    end
  end
end
