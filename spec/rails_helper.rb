# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require "capybara/rails"
require "valid_attribute"
Capybara.javascript_driver = :webkit


Capybara::Webkit.configure do |config|
  config.allow_url("fonts.googleapis.com")
  config.allow_unknown_urls
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Graph.client_class = KoalaFake

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end
  config.after :each do
    Warden.test_reset!
  end

  config.use_transactional_fixtures = false

  OmniAuth.config.test_mode = true
  # OmniAuth.config.mock_auth[:facebook]
  #
  FACEBOOK_INFO = {
     "id"=> "220439",
     "email" => "bret@facebook.com",
   }

  OmniAuth.config.mock_auth[:facebook] =  OmniAuth::AuthHash.new(
  {"provider"=>"facebook",
    "uid"=>"104163923349051",
    "info"=>
      {"email"=>"jax_jnnlnzk_valtchanovberg@tfbnw.net",
        "name"=>"Jax Alabffccjcgef Valtchanovberg",
        "image"=>"http://graph.facebook.com/104163923349051/picture",
        "verified"=>false
      },
      "credentials"=>
      {"token"=>
        "EAAQebgjckX4BAKwNnp9ush1cwFG3F1aKq57qSIf92kqsjupitxr7ZCx6hGnfzUdOEnl3LrLhY0xZCwR6Wi0kOU3mEquuQH08Px1a4yIEUMgliss96EgUfSiRZCxopEj1Y5TgdkGCuURczv1q0VYhP7BuXSYWUsZD",
        "expires_at"=>1472945689,
        "expires"=>true
      },
      "extra"=>
        {"raw_info"=>
          {"name"=>"Jax Alabffccjcgef Valtchanovberg",
            "email"=>"jax_jnnlnzk_valtchanovberg@tfbnw.net",
            "verified"=>false,
            "timezone"=>0,
            "id"=>"104163923349051"}}})


  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

# RSpec.configure do |config|
#   config.include FactoryGirl::Syntax::Methods
# end
