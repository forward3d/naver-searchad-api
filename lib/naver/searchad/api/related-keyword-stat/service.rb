require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module RelatedKeywordStat
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.searchad.naver.com/', '')
          end

          def list_stats(options: nil, &block)
            command = make_command(:get, 'keywordstool', options)
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
