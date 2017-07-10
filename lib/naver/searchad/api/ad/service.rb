module Naver
  module Searchad
    module Api
      module Ad
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/ads/')
          end

          def get_ad(ad_id, &block)

          end

          def create_ad(ad, &block)

          end

          def update_ad(ad, fields, &block)

          end

          def delete_ad(ad_id, &block)

          end
        end
      end
    end
  end
end
