require "naver/searchad/api/version"

module Naver
  module Searchad
    module Api
      ROOT = File.expand_path('..', File.dirname(__dir__))

      def self.logger
        @logger ||= (rails_logger || default_logger)
      end

      class << self
        attr_writer :logger
      end

      private

      def self.default_logger
        logger = Logger.new($stdout)
        logger.level = Logger::WARN
        logger
      end

      def self.rails_logger
        if defined?(::Rails) && ::Rails.respond_to?(:logger) &&
          !::Rails.logger.nil?
          ::Rails.logger
        else
          nil
        end
      end
    end
  end
end
