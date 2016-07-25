require "rails_helper"

feature "user updates their phonenumber", %{
  As an authenticated user
  I want update my profile
  So that I can get texts from my friends
} do
  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end

  context "current_user" do
    let(:current_user) { User.find_by(uid: "104163923349051") }

    scenario "views their own profile" do
      click_link current_user.name
      expect(page).to have_button("Add Phone Number")
    end

    scenario "current user has phonenumber see update Phone Number" do
      current_user.phonenumber = "1123456789"
      current_user.save
      click_link current_user.name
      expect(page).to have_button("Update Phone Number")
    end
  end
end
