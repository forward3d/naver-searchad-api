require 'addressable/uri'
require 'addressable/template'
require 'json'
require_relative '../errors'
require_relative '../options'
require_relative 'logging'

module Naver
  module Searchad
    module Api
      module Core
        class HttpCommand
          include Logging

          attr_reader :url
          attr_reader :method
          attr_accessor :body
          attr_accessor :header
          attr_accessor :options
          attr_accessor :query
          attr_accessor :params

          def initialize(method, url, body: nil)
            @options = RequestOptions.default.dup
            @url = url.is_a?(String) ? Addressable::Template.new(url) : url
            @method = method
            @header = {}
            @body = body
            @query = {}
            @params = {}
          end

          def execute(client, &block)
            prepare!

            _execute(client).tap do |result|
              if block_given?
                yield result, nil
              end
            end

          rescue => e
            if block_given?
              yield nil, e
            else
              raise e
            end
          ensure
            release!
          end

          def prepare!
            normalize_unicode = true
            if options
              @header.merge!(options.header) if options.header
              normalize_unicode = options.normalize_unicode
            end

            if url.is_a?(Addressable::Template)
              @url = url.expand(params, nil, normalize_unicode)
              @url.query_values = query.merge(url.query_values || {})
            end

            @body = '' unless body
          end

          def release!
          end

          def _execute(client)
            logger.debug("Executing HTTP #{method} #{url}")
            request_header = {}
            apply_request_options(request_header)

            http_res = client.request(method.to_s.upcase,
                                      url.to_s,
                                      query: nil,
                                      body: body,
                                      header: request_header,
                                      follow_redirect: true)

            logger.debug("Returned status(#{http_res.status}) and #{http_res.inspect}")
            response = process_response(http_res.status.to_i, http_res.header, http_res.body)

            logger.debug("Success - #{response}")
            success(response)
          rescue => e
            logger.debug("Error - #{e.inspect}")
            error(e)
          end

          def process_response(status, header, body)
            check_status(status, header, body)
            decode_response_body(header['Content-Type'].first, body)
          end

          def check_status(status, header = nil, body = nil, message = nil)
            case status
            when 200...300
              nil
            when 301, 302, 303, 307
              message ||= "Redirect to #{header['Location']}"
              raise Naver::Searchad::Api::RedirectError.new(
                message, status_code: status, header: header, body: body)
            when 401
              message ||= 'Unauthorized'
              raise Naver::Searchad::Api::AuthorizationError.new(
                message, status_code: status, header: header, body: body)
            when 429
              message ||= 'Rate limit exceeded'
              raise Naver::Searchad::Api::RateLimitError.new(
                message, status_code: status, header: header, body: body)
            when 400, 402...500
              message ||= 'Invalid request'
              raise Naver::Searchad::Api::RequestError.new(
                message, status_code: status, header: header, body: body)
            when 500...600
              message ||= 'Server error'
              raise Naver::Searchad::Api::ServerError.new(
                message, status_code: status, header: header, body: body)
            else
              logger.warn("Encountered unexpected status code #{status}")
              message ||= 'Unknown error'
              raise Naver::Searchad::Api::UnknownError.new(
                message, status_code: status, header: header, body: body)
            end
          end

          def decode_response_body(content_type, body)
            body
          end

          private

          def apply_request_options(req_header)
            options.authorization.apply(req_header, url.path, method) if options.authorization.respond_to?(:apply)
            req_header.merge!(header)
          end

          def success(result, &block)
            block.call(result, nil) if block_given?
            result
          end

          def error(err, &block)
            if err.is_a?(HTTPClient::BadResponseError)
              begin
                res = err.res
                check_status(res.status.to_i, res.header, res.body)
              rescue Naver::Searchad::Api::Error => e
                err = e
              end
            elsif err.is_a?(HTTPClient::TimeoutError) || err.is_a?(SocketError)
              err = Naver::Searchad::Api::TransmissionError.new(err)
            end
            if block_given?
              block.call(nil, err)
            else
              raise err
            end
          end
        end
      end
    end
  end
end
