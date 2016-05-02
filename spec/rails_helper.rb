ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_locahost: true)
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /api.lsm.org/).
      to_return(status: 200, body: "stubbed response")
  end
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
