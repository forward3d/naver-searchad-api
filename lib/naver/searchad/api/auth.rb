module Naver
  module Searchad
    module Api
      module Auth
        class CustomerAcccountCredentials
          TIMESTAMP_HEADER = 'X-Timestamp'.freeze
          API_KEY_HEADER = 'X-API-KEY'.freeze
          CUSTOMER_HEADER = 'X-Customer'.freeze
          SIGNATURE_HEADER = 'X-Signature'.freeze

          def initialize(api_key, api_secret, customer_id)
          end

          def apply(hash)
            hash[TIMESTAMP_HEADER] = timestamp
            hash[API_KEY_HEADER] = api_key
            hash[CUSTOMER_HEADER] = customer_id
            hash[SIGNATURE_HEADER] = generate_signature
          end

          private

          def generate_signature
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
