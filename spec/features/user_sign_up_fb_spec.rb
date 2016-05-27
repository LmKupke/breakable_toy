require 'rails_helper'

feature 'sign_up', %Q{
  As an unathenticated user
  I want to sign up through FB
  So that I can get full access to the the web app
} do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end
  scenario 'user signs up valid' do
    # OmniAuth.config.mock_auth[:facebook] = nil
    visit root_path
    click_button "Sign in with Facebook"
    expect(page).to have_content("Successfully authenticated from Facebook account.")
  end

  scenario 'user signs up invalid' do
  #   OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  #   visit root_path
  #   click_button "Sign in with Facebook"
  #   save_and_open_page
  #
  #   expect(page).to have_content("Successfully authenticated from Facebook account.")
  # end

end
