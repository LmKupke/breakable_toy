require 'rails_helper'

feature 'Your Events', %Q{
  As an authenticated user
  I can see Events created by me or joined by me
  So that I can see whats going on
} do
  # Acceptance Criteria:
  # [ X ] Link to Your Event exists on Nav Bar
  # [ - ] Shows all events that belong to me and/or Events I joined(accepted)
  # [ ] After clicking Events link Expect to see table of Events created by User, table of Events accepted with creator name and number of friends attending. Each has a link on the name (make required), link
  # [ ] User sees errors upon entering invalid input

  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    visit root_path
    click_button "Login with Facebook"
  end

  context "current user logged in" do
    let(:current_user) { User.find_by(uid: "12345") }

    scenario 'user sees Your Events in nav' do
      expect(page).to have_content("Your Events")
    end

    # scenario 'user clicks Create a New Event' do
    #   event = create(:event, organizer: current_user)
    #
    #   click_link("Your Events")
    #
    #   expect(page).to have_link("#{event.name}")
    #   expect(page).to have_css('table.organizer')
    #
    # end
  end
end
