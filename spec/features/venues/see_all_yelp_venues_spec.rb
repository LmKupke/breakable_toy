require "rails_helper"

feature "see venues", %{
  As an authenticed user
  I want to see all the venues that might not be in the db
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
  scenario "user sees boston nightlife in nav" do
    expect(page).to have_content("Boston Nightlife")
  end

  scenario "user clicks Boston Nightlife" do
    click_link("Boston Nightlife")
    expect(page).to have_css("#search-form")
  end

  scenario "user clicks venue and shows info page" do
    click_link("Boston Nightlife")
    VCR.use_cassette "search/howl" do
      click_link "Boston Nightlife"
      fill_in "search", with: "Howl"
      click_on "Search"
      click_button("howl-at-the-moon-dueling-piano-bar-boston-2")
      expect(page).to have_content("Howl At The Moon Dueling Piano Bar")
      click_link "Boston Nightlife"
      click_link "Howl At The Moon Dueling Piano Bar"
      expect(page).to have_content("Howl At The Moon Dueling Piano Bar")
    end
  end
end
