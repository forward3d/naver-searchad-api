require_relative 'http_command'

module Naver
  module Searchad
    module Api
      module Core
        class ApiCommand < HttpCommand
          JSON_CONTENT_TYPE = 'application/json'.freeze
          #
          # More error codes can be found at the below url
          # https://github.com/naver/searchad-apidoc/blob/master/NaverSA_API_Error_Code_MAP.md
          #
          ERROR_CODE_MAPPING = {
            '1002' => Naver::Searchad::Api::InvalidRequestError,
            '1018' => Naver::Searchad::Api::NotEnoughPermissionError,
            '3506' => Naver::Searchad::Api::CampaignAlreadyExistError,
          }

          attr_accessor :request_object

          def prepare!
            if request_object
              self.header['Content-Type'] ||= JSON_CONTENT_TYPE
              self.body = request_object.to_json
            end
            super
          end

          def to_snake_case(str)
            str.gsub(/::/, '/').
              gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
                gsub(/([a-z\d])([A-Z])/,'\1_\2').
                  tr("-", "_").
                    downcase
          end

          def decode_response_body(content_type, body)
            return super unless content_type
            return nil unless content_type.start_with?(JSON_CONTENT_TYPE)

            snake_case_hash = {}
            JSON.parse(body).each { |k, v| snake_case_hash[to_snake_case(k)] = v }
            OpenStruct.new(snake_case_hash)
          end

          def check_status(status, header = nil, body = nil, message = nil)
            case status
            when 400, 402..500
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
            message = obj['title']
            message << ", #{obj['detail']}" if obj['detail']

            [obj['code'].to_s, message]
          rescue
            [nil, nil]
          end
        end
      end
    end
  end
end
