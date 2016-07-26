require "rails_helper"

feature "see venues", %{
  As an authenticed user
  I want to see all the venues
  So that I can see whats available
} do
  # Acceptance Criteria:
  # * Has Venues in Nav Bar
  # * Clicking Button Shows paginated bars with photo
  # with name and clickable to show all info

  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end
  context "current_user" do
    let(:current_user) { User.find_by(uid: "104163923349051") }

    scenario "user sees boston nightlife in nav" do
      expect(page).to have_content("Boston Nightlife")
    end

    scenario "user clicks Boston Nightlife" do
      dillions = create(:venue)

      click_link("Boston Nightlife")
      expect(page).to have_content(dillions.name)
      expect(page).to have_css("a##{dillions.id}")
      expect(page).to have_link(dillions.name)
    end

    scenario "user clicks venue and shows info page" do
      dillions = create(:venue)

      click_link("Boston Nightlife")

      click_link(dillions.name)
      expect(page).to have_content(dillions.name)
    end

    scenario "user clicks venue and shows popularity on page" do
      event = create(:event, organizer: current_user)
      venueselection = create(:venueselection, user: current_user, event: event)
      click_link("Boston Nightlife")

      click_link(venueselection.venue.name)
      expect(page).to have_content(venueselection.venue.name)
      expect(page).to have_content("#{venueselection.venue.name} has been selected 1 times for your events and attended events!")
    end

    scenario "user finds venue on another page" do
      create_list(:venue,13)
      click_link("Boston Nightlife")

      click_link "Next"
      expect(page).to have_content("Dillion's")
    end

    scenario "user searches for existing db" do
      bar = create(:venue, name: "World Greatest bar")
      create_list(:venue, 13)

      click_link("Boston Nightlife")
      fill_in "search", with: bar.name
      click_on "Search"
      expect(page).to have_content("Seems like we got that spot!")
    end
  end
end
