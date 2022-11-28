require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module AdKeyword
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.searchad.naver.com/', 'ncc/')
          end

          def list_ad_keywords_by_ids(ad_keyword_ids, options: nil, &block)
            command = make_command(:get, 'keywords', options)
            command.query['ids'] = ad_keyword_ids.join(',')
            execute_command(command, &block)
          end

          def list_ad_keywords_by_adgroup_id(adgroup_id, options: nil, &block)
            command = make_command(:get, 'keywords', options)
            command.query['nccAdgroupId'] = adgroup_id
            execute_command(command, &block)
          end

          def list_ad_keywords_by_label_id(label_id, options: nil, &block)
            command = make_command(:get, 'keywords', options)
            command.query['nccLabelId'] = label_id
            execute_command(command, &block)
          end

          def get_ad_keyword(ad_keyword_id, options: nil, &block)
            command = make_command(:get, 'keywords/{ad_keyword_id}', options)
            command.params['ad_keyword_id'] = ad_keyword_id
            execute_command(command, &block)
          end

          def create_ad_keywords(ad_keywords, adgroup_id, options: nil, &block)
            ad_keywords.each { |kw| validates_presence_of(%w[keyword], kw) }

            command = make_command(:post, 'keywords', options)
            command.query['nccAdgroupId'] = adgroup_id
            command.request_object = ad_keywords
            execute_command(command, &block)
          end

          def update_ad_keyword(ad_keyword, field: '', options: nil, &block)
            validates_presence_of(%w[nccKeywordId nccAdgroupId], ad_keyword)

            command = make_command(:put, 'keywords/{ad_keyword_id}', options)
            command.params['ad_keyword_id'] = ad_keyword['nccKeywordId']
            command.query['fields'] = field
            command.request_object = ad_keyword
            execute_command(command, &block)
          end

          def update_ad_keywords(ad_keywords, field: '', options: nil, &block)
            ad_keywords.each { |kw| validates_presence_of(%w[nccKeywordId nccAdgroupId], kw) }

            command = make_command(:put, 'keywords', options)
            command.query['fields'] = field
            command.request_object = ad_keywords
            execute_command(command, &block)
          end

          def delete_ad_keyword(ad_keyword_id, options: nil, &block)
            command = make_command(:delete, 'keywords/{ad_keyword_id}', options)
            command.params['ad_keyword_id'] = ad_keyword_id
            execute_command(command, &block)
          end

          def delete_ad_keywords(ad_keyword_ids, options: nil, &block)
            command = make_command(:delete, 'keywords', options)
            command.query['ids'] = ad_keyword_ids.join(',')
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
