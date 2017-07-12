module Naver
  module Searchad
    module Api
      RequestOptions = Struct.new(
        :authorization,
        :header,
        :normalize_unicode
      )

      ClientOptions = Struct.new(
        :application_name,
        :application_version,
        :proxy_url,
        :open_timeout_sec,
        :read_timeout_sec,
        :send_timeout_sec,
        :log_http_requests
      )

      class ClientOptions
        def self.default
          @options ||= ClientOptions.new
        end
      end

      class RequestOptions
        def self.default
          @options ||= RequestOptions.new
        end
      end

      ClientOptions.default.log_http_requests = false
      ClientOptions.default.application_name = 'naver-searchad-api'
      ClientOptions.default.application_version = '0.0.0'
      RequestOptions.default.normalize_unicode = false
    end
  end
end
