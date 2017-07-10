require 'naver/searchad/api'

module Naver
  module Searchad
    module Api
      module Core
        module Logging
          def logger
            Naver::Searchad::Api.logger
          end
        end
      end
    end
  end
end
