require 'base64'
require 'openssl'

module Naver
  module Searchad
    module Api
      module Auth
        class CustomerAcccountCredentials
          TIMESTAMP_HEADER = 'X-Timestamp'.freeze
          API_KEY_HEADER = 'X-API-KEY'.freeze
          CUSTOMER_HEADER = 'X-Customer'.freeze
          SIGNATURE_HEADER = 'X-Signature'.freeze

          attr_reader :api_key
          attr_reader :api_secret
          attr_reader :customer_id

          def initialize(api_key, api_secret, customer_id)
            @api_key = api_key
            @api_secret = api_secret
            @customer_id = customer_id
          end

          def apply(hash, request_uri, method)
            timestamp = Time.now.to_i

            hash[TIMESTAMP_HEADER] = timestamp
            hash[API_KEY_HEADER] = api_key
            hash[CUSTOMER_HEADER] = customer_id
            hash[SIGNATURE_HEADER] = generate_signature(api_secret, request_uri, method, timestamp)
          end

          private

          def generate_signature(secret, request_uri, method, timestamp)
            method = method.to_s.upcase if method.is_a?(Symbol)

            Base64.encode64(OpenSSL::HMAC.digest(
              OpenSSL::Digest::SHA256.new,
              secret,
              [timestamp, method, request_uri].join('.')
            )).gsub("\n", '')
          end
        end

        class DefaultCredentials
          API_KEY_ENV_VAR = 'NAVER_API_KEY'.freeze
          API_SECRET_ENV_VAR = 'NAVER_API_SECRET'.freeze
          CUSTOMER_ID_ENV_VAR = 'NAVER_API_CLIENT_ID'.freeze

          def self.from_env
            CustomerAcccountCredentials.new(
              ENV[API_KEY_ENV_VAR],
              ENV[API_SECRET_ENV_VAR],
              ENV[CUSTOMER_ID_ENV_VAR]
              )
          end
        end

        def get_application_default
          DefaultCredentials.from_env
        end

        module_function :get_application_default
      end
    end
  end
end
