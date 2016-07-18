require "rails_helper"

feature "sign_up", %{
  As an unathenticated user
  I want to sign up through FB
  So that I can get full access to the the web app
} do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end
  scenario 'user signs up valid' do
    visit root_path
    find("#faceauth-link").click
    expect(page).to have_content("Successfully authenticated from Facebook account.")
    expect(page).to have_link("Sign Out")
  end
end
