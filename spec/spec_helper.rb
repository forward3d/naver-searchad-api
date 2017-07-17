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
