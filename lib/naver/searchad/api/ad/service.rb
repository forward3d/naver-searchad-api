module Naver
  module Searchad
    module Api
      module Ad
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/')
          end

          def list(ids, options: nil, &block)
          end

          def list_by_adgroup_id(adgroup_id, options: nil, &block)
          end

          def get_ad(ad_id, options: nil, &block)

          end

          def create_ad(ad, options: nil, &block)

          end

          def update_ad(ad, field: nil, options: nil, &block)

          end

          def delete_ad(ad_id, options: nil, &block)

          end

          def copy_ad(ad_id, options: nil, &block)

          end
        end
      end
    end
  end
end
