# Naver Searchad API

A Client GEM for [Naver Searchad API](http://naver.github.io/searchad-apidoc/#/guides)

## Alpha

This library is in Alpha. We will make an effort to support the library, but we reserve the right to make incompatible
changes when necessary.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'naver-searchad-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install naver-searchad-api

## Compatibility

naver-searchad-api supports the following Ruby implementations:

* MRI 2.0
* MRI 2.1
* MRI 2.2
* MRI 2.3

## Usage

### Basic usage

To use an API, instantiate the service. For example to use the Campaign API:

```ruby
require 'naver/searchad/api/campaign/service'

Campaign = Naver::Searchad::Api::Campaign # Alias the module
campaign = Campaign::Service.new
campaign.authorization = Naver::Searchad::Api::Auth.get_application_default # See Below Authorization

# Read campaigns by ids
campaign.list_campaigns_by_ids(['campaign_id_1', 'campaign_id_2']) do |res, err|
  puts res
end

# Create a campaign
campaign = { ..... }
campaign.create_campaign(campaign) do |res, err|
  puts res
end

# Delete
campaign_id = ... # A campaign id to delete
campaign.delete_campaign(campaign_id)
```

### Naming conventions vs JSON representation

Object properties in the ruby client use the standard ruby convention for naming -- snake_case. This differs from the underlying JSON representation which typically uses camelCase for properties.


### Callbacks

A block can be specified when making calls. If present, the block will be called with the result or error, rather than
returning the result from the call or raising the error. Example:

```ruby
# Read a campaign
campaign.get_campaign('campaign_id_1') do |res, err|
  if err
    # Handle error
  else
    # Handle response
  end
end
```

## Authorization

[Naver Searchad API authorization](http://naver.github.io/searchad-apidoc/#/samples) is used to authorize applications.

### Authorization using environment variables

The [Naver Searchad API Auth](https://github.com/forward3d/naver-searchad-api/blob/master/lib/naver/searchad/api/auth.rb) also supports authorization via
environment variables if you do not want to check in developer credentials
or private keys. Simply set the following variables for your application:

```sh
NAVER_API_KEY="YOUR NAVER DEVELOPER API KEY"
NAVER_API_SECRET="YOUR NAVER DEVELOPER API SECRET"
NAVER_API_CLIENT_ID="YOUR NAVER DEVELOPER CLIENT ID"
```

## Logging

The client includes a `Logger` instance that can be used to capture debugging information.

To set the logging level for the client:

```ruby
Naver::Searchad::Api.logger.level = Logger::DEBUG
```

When running in a Rails environment, the client will default to using `::Rails.logger`. If you
prefer to use a separate logger instance for API calls, this can be changed via one of two ways.

The first is to provide a new logger instance:

```ruby
Naver::Searchad::Api.logger = Logger.new(STDERR)
```

## License

This library is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/forward3d/naver-searchad-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

We encourage contributors to follow [Bozhidar's ruby style guide](https://github.com/bbatsov/ruby-style-guide) in this project.

Pull requests (with tests) are appreciated. Please help with:

* Reporting bugs
* Suggesting features
* Writing or improving documentation
* Fixing typos
* Cleaning whitespace
* Refactoring code
* Adding tests

If you report a bug and don't include a fix, please include a failing test.

