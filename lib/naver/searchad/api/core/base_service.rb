require 'addressable/uri'
require 'addressable/template'
require 'httpclient'
require 'naver/searchad/api/options'
require 'naver/searchad/api/version'
require 'naver/searchad/api/core/api_command'
require 'naver/searchad/api/core/logging'

module Naver
  module Searchad
    module Api
      module Core
        class BaseService
          include Logging

          attr_reader :url
          attr_reader :base_path
          attr_accessor :request_options
          attr_accessor :client_options

          def initialize(url, base_path)
            @url = url
            @base_path = base_path
            @request_options = RequestOptions.default.dup
            @client_options = ClientOptions.default.dup
          end

          def authorization=(authorization)
            @request_options.authorization = authorization
          end

          def authorization
            request_options.authorization
          end

          def client
            @client ||= new_client
          end

          protected

          def make_command(method, path, options)
            command = ApiCommand.new(method, Addressable::Template.new(url + base_path + path))
            command.options = request_options.merge(options)
            apply_command_defaults(command)
            command
          end

          def execute_command(command, &block)
            command.execute(client, &block)
          end

          def apply_command_defaults(command)
          end

          private

          def new_client
            HTTPClient.new.tap do |client|
              client.transparent_gzip_decompression = true
              client.proxy = client_options.proxy_url if client_options.proxy_url
              client.connect_timeout = client_options.open_timeout_sec if client_options.open_timeout_sec
              client.receive_timeout = client_options.read_timeout_sec if client_options.read_timeout_sec
              client.send_timeout = client_options.send_timeout_sec if client_options.send_timeout_sec
              client.follow_redirect_count = 5
              client.default_header = { 'User-Agent' => user_agent }
              client.debug_dev = logger if client_options.log_http_requests
            end
          end

          def user_agent
            "#{client_options.application_name}/#{client_options.application_version} "\
            "naver-searchad-api/#{Naver::Searchad::Api::VERSION} "\
            "#{Naver::Searchad::Api::OS_VERSION} (gzip)"
          end
        end
      end
    end
  end
end
