require "rails_helper"

feature "User adds Venue from Yelp", %{
  As an authenticated User
  I can add the Venue from Yelp
  So I can use it later in the DB
} do
  # Acceptance Criteria:
  # [ X ] Link to Boston Nightlife exists on Nav Bar
  # [ X ] Sees Venues in the Database
  # [ X ] Searches in the Yelp Search Bar
  # [ X ] Get a table of possible choices
  # [ X ] Click add to DB button and expect to see the show page

  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end

  describe "Yelp Lookup" do
    it "should return a bar that isn't in the database" do
      VCR.use_cassette "search/howl" do
        click_link "Boston Nightlife"
        fill_in "search", with: "Howl"
        click_on "Search"
        expect(page).to have_css("table")
        expect(page).to have_content("Howl At The Moon Dueling Piano Bar")
      end
    end
  end

  describe "Yelp Lookup and add to DB" do
    it "should return a bar that isn't in the database and be added to DB" do
      VCR.use_cassette "search/howl" do
        click_link "Boston Nightlife"
        fill_in "search", with: "Howl"
        click_on "Search"
        click_button('howl-at-the-moon-dueling-piano-bar-boston-2')
        expect(page).to have_content("Howl At The Moon Dueling Piano Bar")
        expect(page).to have_content("Bars")
        expect(page).to have_content("Music Venues")
      end
    end

    it "should return a bar that isn't in the database and be added to DB" do
      VCR.use_cassette "search/howl" do
        click_link "Boston Nightlife"
        fill_in "search", with: "Howl"
        click_on "Search"
        click_button('howl-at-the-moon-dueling-piano-bar-boston-2')
        expect(page).to have_content("Howl At The Moon Dueling Piano Bar")
        click_link "Boston Nightlife"
        expect(page).to have_content("Howl At The Moon Dueling Piano Bar")
      end
    end
  end
end
