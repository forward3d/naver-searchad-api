require 'addressable/uri'
require 'addressable/template'
require 'httpclient'
require_relative '../options'
require_relative '../version'
require_relative 'api_command'
require_relative 'download_command'
require_relative 'logging'

module Naver
  module Searchad
    module Api
      module Core
        class BaseService
          include Logging

          attr_accessor :request_options
          attr_accessor :client_options
          attr_reader :url
          attr_reader :base_path

          def initialize(url, base_path = '')
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

          def make_command(method, path, options = {})
            template = Addressable::Template.new(url + base_path + path)
            command = ApiCommand.new(method, template)
            command.decode_snake_case = options.fetch(:decode_snake_case, true) if options
            command.options = request_options.merge(options)
            apply_command_defaults(command)
            command
          end

          def make_download_command(method, path, options = {})
            template = Addressable::Template.new(url + base_path + path)
            command = DownloadCommand.new(method, template)
            command.options = request_options.merge(options)
            apply_command_defaults(command)
            command
          end

          def execute_command(command, &block)
            command.execute(client, &block)
          end

          def apply_command_defaults(command)
            # To be implemented by subclasses
          end

          def validates_presence_of(fields, object)
            fields.each do |key|
              unless object.key?(key)
                raise MissingRequiredAttributeError.new(
                  "Require #{key} attribute in object")
              end
            end
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
