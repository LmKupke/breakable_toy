require 'rails_helper'

feature 'user views newsfeed', %Q{
  As an authenticated user
  I want to see current upcoming events that friends have organized
  So that I can ask to join them
} do

  # Acceptance Criteria:
  # [ ] User is redirected newsfeed after login
  # [ ] Newsfeed contains a list of friends' upcoming events
  # [ ] Each event will contain the friend name and avatar
  # [ ] Clicking on an event will take me to the event show page

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path

    find("#faceauth-link").click
  end

  xscenario "user logs in and sees newsfeed" do
    expect(current_path).to eq newsfeeds_path
    # @test_users = Koala::Facebook::TestUsers.new(app_id: id, secret: secret)
    # user = @test_users.create(is_app_installed, desired_permissions)
    # user_graph_api = Koala::Facebook::API.new(user["access_token"])
    # # or, if you want to make a whole community:
    # @test_users.create_network(network_size, is_app_installed, common_permissions)

  end
end
