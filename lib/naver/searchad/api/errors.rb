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

      RedirectError = Class.new(Error)

      AuthorizationError = Class.new(Error)

      RequestError = Class.new(Error)

      RateLimitError = Class.new(Error)

      ServerError = Class.new(Error)

      UnknownError = Class.new(Error)

      TransmissionError = Class.new(Error)

      NotEnoughPermissionError = Class.new(RequestError)

      MissingRequiredAttributeError = Class.new(RequestError)

      InvalidRequestError = Class.new(RequestError)

      DuplicatedCampaignNameError = Class.new(RequestError)

      DuplicatedAdgroupNameError = Class.new(RequestError)
    end
  end
end
