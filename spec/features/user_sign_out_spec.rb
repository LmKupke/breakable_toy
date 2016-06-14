require 'rails_helper'

feature 'Sign_out', %Q{
  As an authenticated user
  I want to sign out
  So that I can leave the application
} do
  # Acceptance Criteria:
  # * Link to Sign Out in Nav Bar
  # * Upon clicking Sign Out user is redirected to Landing Page

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end
  scenario 'user signs out' do
    # OmniAuth.config.mock_auth[:facebook] = nil
    visit root_path
    find("#faceauth-link").click

    expect(page).to have_link("Sign Out")

    click_link "Sign Out"

    expect(page).to have_content("Signed out successfully.")
  end
end
