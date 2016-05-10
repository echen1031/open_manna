ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'
require 'support/factory_girl'
require 'support/warden'
require 'support/shoulda_matchers'
require 'support/rspec_sidekiq'

WebMock.disable_net_connect!(allow_locahost: true)
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "https://rest.nexmo.com/sms/json").with(:body => {"api_key"=>ENV['NEXMO_API_KEY'], "api_secret"=>ENV['NEXMO_API_SECRET'], "from"=>"Open Manna", "text"=>"This is a test verse","to"=>"15555555555"}, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'ruby-nexmo/4.1.0/2.2.1'}).to_return(:status => 200, :body => "", :headers => {})
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
