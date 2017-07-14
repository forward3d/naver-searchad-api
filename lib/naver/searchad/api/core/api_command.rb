require_relative 'http_command'

module Naver
  module Searchad
    module Api
      module Core
        class ApiCommand < HttpCommand
          JSON_CONTENT_TYPE = 'application/json'.freeze

          attr_accessor :request_object

          def prepare!
            if request_object
              self.header['Content-Type'] ||= JSON_CONTENT_TYPE
              self.body = request_object.to_json
            end
            super
          end

          def decode_response_body(content_type, body)
            return super unless content_type
            return nil unless content_type.start_with?(JSON_CONTENT_TYPE)
            JSON.parse(body)
          end

          def check_status(status, header = nil, body = nil, message = nil)
            super(status, header, body, message)
          end
        end
      end
    end
  end
end
