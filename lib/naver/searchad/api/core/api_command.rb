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
            '3506' => Naver::Searchad::Api::DuplicatedCampaignNameError,
            '3710' => Naver::Searchad::Api::DuplicatedAdgroupNameError,
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

            decoded_response = JSON.parse(body)
            deep_snake_case_params!(decoded_response)
            if decoded_response.kind_of?(Hash)
              OpenStruct.new(decoded_response)
            elsif decoded_response.kind_of?(Array)
              decoded_response.map { |h| OpenStruct.new(h) }
            end
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

          def deep_snake_case_params!(val)
            case val
            when Array
              val.map {|v| deep_snake_case_params! v }
            when Hash
              val.keys.each do |k, v = val[k]|
                val.delete k
                val[to_snake_case(k)] = deep_snake_case_params!(v)
              end
              val
            else
              val
            end
          end

          def to_snake_case(str)
            str.gsub(/::/, '/').
              gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
                gsub(/([a-z\d])([A-Z])/,'\1_\2').
                  tr("-", "_").
                    downcase
          end

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
