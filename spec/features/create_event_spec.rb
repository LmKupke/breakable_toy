require 'rails_helper'

feature 'See User Events', %Q{
  As an authenticated user
  I can create an Event
  So that I have a plan
} do
  # Acceptance Criteria:
  # [ ] Link to Create Event exists on Nav Bar
  # [ ] Create Event form requires user to specify date
  # [ ] Upon successful submission user is redirected to the Event#show page for the newly created event and Asks to pick a Venue and Asks to add Friends
  # [ ] User sees errors upon entering invalid input


  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path
    click_button "Login with Facebook"
  end
  scenario 'user sees Create Event in nav' do
    expect(page).to have_content("Create a New Event")
  end

  scenario 'user clicks Create a New Event' do
    click_link("Create a New Event")

    expect(page).to have_css('form input#event_name')
    expect(page).to have_css('form input#dpt')
    expect(page).to have_css('form input#timepicker')


  end
  scenario 'user creates a new Event goes to show page' do
    click_link("Create a New Event")
    fill_in('Event Name', :with => 'Crazy Friday Night')
    fill_in('Date', :with => '2016/06/01')
    fill_in('Start Time', :with => '10 : 00 PM')

    click_button('Create Event')

    expect(page).to have_content("Crazy Friday Night")
    expect(page).to have_content("06/01/2016")
    expect(page).to have_content("10 : 00 PM")

  end
  scenario 'user creates a invalid new Event with only name goes to shows form again with error' do
    click_link("Create a New Event")
    fill_in('Event Name', :with => 'Crazy Friday Night')
    fill_in('Date', :with => 'this is incorrect')
    fill_in('Start Time', :with => 'this is incorrect')

    click_button('Create Event')

    expect(page).to_not have_content("Crazy Friday Night")
  end

  scenario 'user creates a invalid new Event goes to shows form again with error' do
    click_link("Create a New Event")
    fill_in('Event Name', :with => '')
    fill_in('Date', :with => 'this is incorrect')

    click_button('Create Event')

    expect(page).to_not have_content("Crazy Friday Night")
  end
end
