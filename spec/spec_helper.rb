if ENV['COVERAGE'] = 'true'
  require 'simplecov'

  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter
  ]
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'rspec'
require 'webmock/rspec'
require 'naver/searchad/api'
require 'naver/searchad/api/core/base_service'
require 'naver/searchad/api/auth'
require 'naver/searchad/api/campaign/service'

ENV['NAVER_API_KEY'] = '0100000000f2e75122770874cb904034e7e27f5815c21af53a93f25b0f05f0ce97f263650c'
ENV['NAVER_API_SECRET'] = 'AQAAAADy51Eidwh0y5BANOfif1gVwHjWG4MrXg6Mbh54YHY4MQ=='
ENV['NAVER_API_CLIENT_ID'] = '1077530'

RSpec.configure do |config|
  config.include WebMock::API

  Naver::Searchad::Api.logger.level = Logger::DEBUG
  WebMock::Config.instance.query_values_notation = :flat_array

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
