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
require 'naver/searchad/api/core/helpers'
require 'naver/searchad/api/auth'
require 'naver/searchad/api/ad/service'
require 'naver/searchad/api/ad-keyword/service'
require 'naver/searchad/api/adgroup/service'
require 'naver/searchad/api/bizmoney/service'
require 'naver/searchad/api/business-channel/service'
require 'naver/searchad/api/campaign/service'
require 'naver/searchad/api/label/service'
require 'naver/searchad/api/related-keyword-stat/service'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

ENV['NAVER_API_KEY'] = 'test_api_key'
ENV['NAVER_API_SECRET'] = 'test_api_key_secret'
ENV['NAVER_API_CLIENT_ID'] = '11121212121'

RSpec.configure do |config|
  config.include WebMock::API

  Naver::Searchad::Api.logger.level = Logger::WARN
  WebMock::Config.instance.query_values_notation = :flat_array

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
