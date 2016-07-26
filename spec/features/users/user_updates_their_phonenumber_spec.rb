require "rails_helper"

feature "user updates their phonenumber", %{
  As an authenticated user
  I want update my profile
  So that I can get texts from my friends
}, js: true do
  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    Capybara.server_host= 'localhost' #this is the goal
    Capybara.server_port = 3000
    visit root_path
    find("#faceauth-link").click
  end

  context "current_user" do
    let(:current_user) { User.find_by(uid: "104163923349051") }

    scenario "views their own profile", js: false do
      click_link(current_user.name)
      expect(page).to have_button("Add Phone Number")
    end

    scenario "current user has phonenumber see update Phone Number", js: false do
      current_user.phonenumber = "1123456789"
      current_user.save
      click_link(current_user.name)

      expect(page).to have_button("Update Phone Number")
    end

    scenario "current_user sees form adds invalid phonenumber" do
      find_link(current_user.name).trigger("click")
      click_button("Add Phone Number")
      fill_in("Phone Number", with: "112345678")
      click_button "Submit"

      expect(page).to have_content("The phone number you
          submitted is invalid! Please submit valid 10 digit US number"
        )
      expect(page).to have_css("form")
    end

    scenario "current_user sees form and update their phonenumber" do
      current_user.phonenumber = "1123456789"
      current_user.save
      find_link(current_user.name).trigger("click")
      click_button("Update Phone Number")
      fill_in("Phone Number", with: "1123456787")
      click_button "Submit"

      expect(page).to have_content("You have successfully saved your phone number!")
      expect(page).to have_css("form")
    end
  end
end
