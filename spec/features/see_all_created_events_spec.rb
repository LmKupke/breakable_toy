require 'rails_helper'

feature 'Your Events', %Q{
  As an authenticated user
  I can see Events created by me or joined by me
  So that I can see whats going on
} do
  # Acceptance Criteria:
  # [ X ] Link to Your Upcoming Event exists on Nav Bar
  # [ X ] Shows all events that belong to me
  # [ ] After clicking Your Upcoming Events link Expect to see table of Events created by User, table of Events accepted with creator name and number of friends attending
  # [ X ] User sees errors upon entering invalid input

  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    visit root_path
    click_button "Login with Facebook"
  end

  context "current user logged in" do
    let(:current_user) { User.find_by(uid: "12345") }

    scenario 'user sees Your Upcoming Events in nav' do
      expect(page).to have_content("Your Upcoming Events")
    end

    scenario 'user clicks Create a New Event' do
      event = create(:event, organizer: current_user)
      click_link("Your Upcoming Events")

      expect(page).to have_link("#{event.name}")
    end
    scenario 'user clicks Create a New Event' do
      event = create(:event, organizer: current_user)
      click_link("Your Upcoming Events")
      click_link("#{event.name}")
      expect(page).to have_content("#{event.name}")
      expect(page).to have_button("Add Boston Nightlife")
    end
  end
end
