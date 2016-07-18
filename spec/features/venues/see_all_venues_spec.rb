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
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end

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

  scenario "user finds venue on another page" do
    create_list(:venue,10)
    click_link("Boston Nightlife")

    click_link "Next"
    expect(page).to have_content("Dillion's")
  end
end
