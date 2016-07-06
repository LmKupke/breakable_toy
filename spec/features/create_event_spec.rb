require 'rails_helper'

feature 'See User Events', %Q{
  As an authenticated user
  I can create an Event
  So that I have a plan
} do
  # Acceptance Criteria:
  # [ X ] Link to Create Event exists on Nav Bar
  # [ X ] Create Event form requires user to specify date
  # [ X ] Upon successful submission user is redirected to the Event#show page for the newly created event and Asks to pick a Venue and Asks to add Friends
  # [ X ] User sees errors upon entering invalid input


  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    # test_users = Koala::Facebook::TestUsers.new(app_id: ENV["FB_APP_ID"], secret: ENV["FB_APP_SECRET"])
    # @facebook_user = test_users.create(true, "email,user_friends")
    # @friend = test_users.create(true, "email,user_friends")
    # test_users.befriend(@facebook_user, @friend)
    #
    #
    # @original_user = create(:user, uid: @facebook_user["id"], token: @facebook_user["access_token"], email: @facebook_user['email'], password: @facebook_user["password"], provider: "facebook", name: "Jax Teller")
    # @friend_user = create(:user, uid: @friend["id"], token: @friend["access_token"], email: @friend['email'], password: @friend["password"], provider: "facebook", name: "Jon Snow")
    visit root_path

    find("#faceauth-link").click

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
    a = Time.zone.today.beginning_of_day
    a = a + 2.weeks
    click_link("Create a New Event")
    fill_in('Event Name', :with => 'Crazy Friday Night')
    fill_in('Date', :with => a)
    fill_in('Start Time', :with => '10 : 00 PM')

    click_button('Create Event')

    expect(page).to have_content("Crazy Friday Night")
    expect(page).to have_content(a.strftime("%m/%d/%Y"))
    expect(page).to have_content("10 : 00 PM")

  end
  scenario 'user creates a invalid new Event with only name goes to shows form again with error' do
    click_link("Create a New Event")
    fill_in('Event Name', :with => 'Crazy Friday Night')
    fill_in('Date', :with => '06/01/2016')
    fill_in('Start Time', :with => '10 : 00 PM')

    click_button('Create Event')

    expect(page).to_not have_content("Crazy Friday Night")
  end
end
