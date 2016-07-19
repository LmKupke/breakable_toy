require "rails_helper"

feature "event invitee invites friend to event", %{
  As an invited user
  I want to invite mutual friends
  So that more people can attend the event
} do
  # Acceptance Criteria:
  # [ ] Invitee accepts event
  # [ ] Invites a valid friend and sees Success Message on Event#show
  # [ ] Invites an invalid friend and sees Falure Message on Event#show

  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end

  context "current_user" do
    let!(:current_user) { User.find_by(uid: "104163923349051") }
    let!(:koalafake) { KoalaFake.new(current_user.token, ENV["FB_APP_SECRET"]) }
    let!(:date) { Time.zone.now + 1.week }
    let!(:friendlist) { koalafake.get_connections("me", "friends") }
    let!(:friend) {
      create(:user, name: friendlist[0]["name"], uid: friendlist[0]["id"])
    }
    let!(:friend1) {
      create(:user, name: friendlist[1]["name"], uid: friendlist[1]["id"])
    }
    let!(:friend2) {
      create(:user, name: friendlist[-1]["name"], uid: friendlist[-1]["id"])
    }

    let!(:event) { create(:event, organizer: friend, date: date) }
    let!(:vselect) { create(:venueselection, user: friend, event: event) }

    let!(:invite) {
      Invite.create(inviter: friend, invitee: current_user, event: event, status: "Attending")
    }

    scenario "invitee first must select a venue" do
      click_link "Your Upcoming Events"
      click_link event.name

      expect(page).to have_button("Add Boston Nightlife")
    end

    scenario "invitee selects venue already in the queue" do
      click_link "Your Upcoming Events"
      click_link event.name
      click_button("Add Boston Nightlife")
      click_button("Add to Your Event")

      expect(page).to have_content("Sorry one of your friends already selected that place!")
    end

    scenario "invitee selects a different venue" do
      venue = create(:venue, yelp_id: "drink-boston-1", name: "Drink")
      click_link "Your Upcoming Events"
      click_link event.name
      click_button("Add Boston Nightlife")
      click_button("drink-boston-1")

      expect(page).to have_link(venue.name)
    end

    scenario "invitee invites invalid friend to event" do
      venue = create(:venue, yelp_id: "drink-boston-1", name: "Drink")
      create(:venueselection, venue: venue, user: current_user, event: event)
      click_link "Your Upcoming Events"
      click_link event.name

      fill_in("search", with: "John Snow")

      click_button("Invite Friends")
      expect(page).to have_content("Your friend, John Snow is either not on the app, or already invited.")
    end

    scenario "invitee invites valid mutual friend to event" do
      venue = create(:venue, yelp_id: "drink-boston-1", name: "Drink")
      create(:venueselection, venue: venue, user: current_user, event: event)

      click_link "Your Upcoming Events"
      click_link event.name

      fill_in("search", with: "Charlie Alabeicdfjfdi Smithson")

      click_button("Invite Friends")
      expect(page).to have_content("You successfully added Charlie Alabeicdfjfdi Smithson!")
    end

    scenario "invitee invites already invited mutual friend" do
      venue = create(:venue, yelp_id: "drink-boston-1", name: "Drink")
      create(:venueselection, venue: venue, user: current_user, event: event)

      Invite.create(
        inviter: friend,
        invitee: friend2,
        event: event,
        status: "Attending"
      )

      click_link "Your Upcoming Events"
      click_link event.name

      fill_in("search", with: "Charlie Alabeicdfjfdi Smithson")
      click_button("Invite Friends")

      expect(page).to have_content("Your friend, Charlie Alabeicdfjfdi Smithson is either not on the app, or already invited.")
    end
  end
end
