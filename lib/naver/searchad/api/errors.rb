module Naver
  module Searchad
    module Api
      class Error < StandardError
        attr_reader :status_code
        attr_reader :header
        attr_reader :body

        def initialize(err, status_code: nil, header: nil, body: nil)
          @cause = nil

          if err.respond_to?(:backtrace)
            super(err.message)
            @cause = err
          else
            super(err.to_s)
          end
          @status_code = status_code
          @header = header unless header.nil?
          @body = body
        end

        def backtrace
          if @cause
            @cause.backtrace
          else
            super
          end
        end
      end # Error

      class RedirectError < Error; end

      class AuthorizationError < Error; end

      class RequestError < Error; end

      class RateLimitError < Error; end

      class ServerError < Error; end

      class UnknownError < Error; end

      class TimeoutError < Error; end
    end
  end
end
