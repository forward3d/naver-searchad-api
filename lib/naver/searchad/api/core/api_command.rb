require_relative 'http_command'

module Naver
  module Searchad
    module Api
      module Core
        class ApiCommand < HttpCommand
          JSON_CONTENT_TYPE = 'application/json'.freeze
          ERROR_CODE_MAPPING = {
            '1018' => Naver::Searchad::Api::NotEnoughPermissionError
          }

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
            case status
            when 400, 402...500
              code, message = parse_error(body)
              raise ERROR_CODE_MAPPING[code].new(
                message,
                status_code: status,
                header: header,
                body: body
              ) if ERROR_CODE_MAPPING.key?(code)
            end

            super(status, header, body, message)
          end

          private

          def parse_error(body)
            obj = JSON.parse(body)
            [obj['code'].to_s, obj['title']]
          rescue
            [nil, nil]
          end
        end
      end
    end
  end
end
