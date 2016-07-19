require "rails_helper"

feature "Edits an existing", %{
  As an event organizer
  I can update an Event
  So that my friends know whats going on
} do
  # Acceptance Criteria:
  # [ X ] Link to Create Event exists on Nav Bar
  # [ X ] Create Event form requires user to specify date
  # [ X ] Upon successful submission user is redirected to the Event#show page
  # for the newly updated event and Asks to pick a Venue and Asks to add Friends
  # [ X ] User sees errors upon entering invalid input

  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    visit root_path

    find("#faceauth-link").click
  end

  context "current_user" do
    let(:current_user) { User.find_by(uid: "104163923349051") }
    let!(:event) { create(:event, organizer: current_user) }

    scenario "user sees Update Event button in Event#show" do
      click_link "Your Upcoming Events"
      click_link(event.name)

      expect(page).to have_button("Edit Event")
    end

    scenario "event organizer user clicks Edit Event" do
      click_link "Your Upcoming Events"
      click_link(event.name)
      click_button("Edit Event")

      expect(page).to have_css("form input#event_name")
      expect(page).to have_css("form input#dpt")
      expect(page).to have_css("form input#timepicker")
    end

    scenario "event organizer doesnt make changes" do
      click_link "Your Upcoming Events"
      click_link(event.name)
      click_button("Edit Event")
      click_button("Update Event")

      expect(page).to have_content(event.name)
      expect(page).to have_content(event.date.strftime("%m/%d/%Y"))
      expect(page).to have_content(event.start_time)
      expect(page).to have_content("You updated your event")
    end

    scenario "event organizer enters valid new time to update event" do
      click_link "Your Upcoming Events"
      click_link(event.name)
      click_button("Edit Event")

      a = Time.zone.today.beginning_of_day
      a += 2.weeks

      fill_in("Event Name", with: event.name)
      fill_in("Date", with: event.date)
      fill_in("Start Time", with: "2 : 00 PM")
      click_button("Update Event")

      expect(page).to have_content(event.name)
      expect(page).to have_content(event.date.strftime("%m/%d/%Y"))
      expect(page).to have_content("2 : 00 PM")
      expect(page).to have_content("You updated your event")
    end

    scenario "event organizer enters valid new date to update event" do
      click_link "Your Upcoming Events"
      click_link(event.name)
      click_button("Edit Event")

      a = Time.zone.today.beginning_of_day
      a += 2.weeks

      fill_in("Event Name", with: event.name)
      fill_in("Date", with: a)
      fill_in("Start Time", with: event.start_time)
      click_button("Update Event")

      expect(page).to have_content(event.name)
      expect(page).to have_content(a.strftime("%m/%d/%Y"))
      expect(page).to have_content(event.start_time)
      expect(page).to have_content("You updated your event")
    end

    scenario "event org enters invalid date" do
      click_link "Your Upcoming Events"
      click_link(event.name)
      click_button("Edit Event")

      fill_in("Event Name", with: "Crazy Friday Night")
      fill_in("Date", with: "06/01/2016")
      fill_in("Start Time", with: "10 : 00 PM")

      click_button("Update Event")

      expect(page).to_not have_content("Crazy Friday Night")
      expect(page).to have_content("Please add values to each of the forms")
    end
  end
end
