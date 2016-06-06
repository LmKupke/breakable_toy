require 'rails_helper'

feature 'see venues', %Q{
  As an authenticed user
  I want to see all the venues that might not be in the db
  So that I can see whats available
} do
  # Acceptance Criteria:
  # * Has Venues in Nav Bar
  # * Clicking Button Shows paginated bars with photo
  # with name and clickable to show all info


  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path
    click_button "Login with Facebook"
  end
  scenario 'user sees boston nightlife in nav' do
    expect(page).to have_content("Boston Nightlife")
  end

  scenario 'user clicks Boston Nightlife' do
    click_link("Boston Nightlife")
    expect(page).to have_css('#search-form')

  end
  scenario 'user clicks venue and shows info page' do
    click_link("Boston Nightlife")
    # within(:css, "input#search") do
      # fill_in 'Name', :with => 'Jimmy'
    # end
    # fill_in('Search Venues', :with => "Jerry Remy's")
    # click_link "Search"
    # expect(page).to have_content("Jerry Remy's Sports Bar & Grill")
  end

end
