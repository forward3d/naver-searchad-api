module Naver
  module Searchad
    module Api
      module Core
        class BaseService
          include Logging

          attr_reader :url
          attr_reader :path

          def initialize(url, path)
            @url = url
            @path = path
            @request_options = Struct.new(
              :authorization,
              :header
            )
          end

          def authorization=(authorization)
            @request_options.authorization = authorization
          end
        end
      end
    end
  end
end
