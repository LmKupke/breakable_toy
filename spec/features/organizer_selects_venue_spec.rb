require 'rails_helper'

feature 'Event Organizer adds Venue', %Q{
  As the Event Organizer
  I can add the Venue
  So I have an intial idea
} do
  # ACCEPTANCE CRITERIA:</u>**
  # [ ] Button to Add Venue on Event#show page (if current date is not passed)
  # [ ] Button shows Add Friends after Venue added not before
  # [ ] Successful addition shows Event#show page with Venue

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end
  context "current user logged in" do
    let(:current_user) { User.find_by(uid: "12345") }

    scenario 'Organizer creates an Event sees Add Boston Nightlife Button' do
      @event = create(:event, organizer: current_user )
      click_link "Your Upcoming Events"

      click_link "#{@event.name}"
      expect(page).to have_button("Add Boston Nightlife")
      expect(page).to_not have_link("Invite Friends")
    end

    scenario 'Organizer creates an Event sees Add Boston Nightlife Button' do
      event = create(:event, organizer: current_user)
      venue = create(:venue)
      click_link "Your Upcoming Events"
      click_link "#{event.name}"
      click_button "Add Boston Nightlife"

      expect(page).to have_content("#{venue.name}")
      expect(page).to have_button("Add to Your Event")
    end

    scenario 'Organizer creates an Event sees Add Boston Nightlife Button' do
      event = create(:event, organizer: current_user)
      venue = create(:venue)
      click_link "Your Upcoming Events"
      click_link "#{event.name}"
      click_button "Add Boston Nightlife"
      click_button("Add to Your Event")

      expect(page).to have_content(event.name)
      expect(page).to have_content(event.date.strftime("%m/%d/%Y"))
      expect(page).to have_content(venue.name)
      expect(page).to have_button("Invite Friends")
    end
  end
end
