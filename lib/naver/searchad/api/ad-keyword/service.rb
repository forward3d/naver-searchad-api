module Naver
  module Searchad
    module Api
      module AdKeyword
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/keywords/')
          end

          def list_ad_keywords_by_ids(ad_keyword_ids, &block)

          end

          def list_ad_keywords_by_adgroup_id(adgroup_id, &block)

          end

          def list_ad_keywords_by_label_id(label_id, &block)

          end

          def get_ad_keyword(ad_keyword_id, &block)

          end

          def create_ad_keyword(ad_keyword, &block)

          end

          def update_ad_keyword(ad_keyword, fields, &block)

          end

          def delete_ad_keyword(ad_keyword_id, &block)
          end
        end
      end
    end
  end
end
