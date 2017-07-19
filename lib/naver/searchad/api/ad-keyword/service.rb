module Naver
  module Searchad
    module Api
      module AdKeyword
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/')
          end

          def list_ad_keywords_by_ids(ad_keyword_ids, options: nil, &block)
            command = make_command(:get, 'keywords', options)
            command.query['ids'] = ad_keyword_ids.join(',')
            execute_command(command, &block)
          end

          def list_ad_keywords_by_adgroup_id(adgroup_id, options: nil, &block)

          end

          def list_ad_keywords_by_label_id(label_id, options: nil, &block)

          end

          def get_ad_keyword(ad_keyword_id, options: nil, &block)

          end

          def create_ad_keyword(ad_keyword, options: nil, &block)

          end

          def update_ad_keyword(ad_keyword, fields: nil, options: nil, &block)

          end

          def delete_ad_keyword(ad_keyword_id, options: nil, block)
          end
        end
      end
    end
  end
end
