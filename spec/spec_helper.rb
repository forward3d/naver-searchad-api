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
require 'naver/searchad/api/ad-keyword/service'
require 'naver/searchad/api/adgroup/service'
require 'naver/searchad/api/campaign/service'

ENV['NAVER_API_KEY'] = 'test_api_key'
ENV['NAVER_API_SECRET'] = 'test_api_key_secret'
ENV['NAVER_API_CLIENT_ID'] = '11121212121'

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
