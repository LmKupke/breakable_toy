# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require "capybara/rails"
require "valid_attribute"

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }


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

  config.use_transactional_fixtures = true

  OmniAuth.config.test_mode = true
  # OmniAuth.config.mock_auth[:facebook]
  #
  FACEBOOK_INFO = {
     "id"=> "220439",
     "email" => "bret@facebook.com",
   }

  OmniAuth.config.mock_auth[:facebook] =  OmniAuth::AuthHash.new({
     "uid" => '12345',
     "provider" => 'facebook',
     "info" => {"name" => "Bret Taylor", "email" => 'example@gmail.com', "image" => 'photo.png'},
     "credentials" => {"token" => 'plataformatec'},
     "extra" => {"user_hash" => FACEBOOK_INFO}
   })


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
