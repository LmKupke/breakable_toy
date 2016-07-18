require "rails_helper"

feature "event organizer invites friend", %{
  As an event organizer
  I want to invite friends
  So that I can attend my event
} do
  # Acceptance Criteria:
  # [ ] User creates an event
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
    let!(:event) { create(:event, organizer: current_user, date: date) }

    let!(:vselect) { create(:venueselection, user: current_user, event: event) }

    scenario "event organizer invites valid friend to event" do
      friend = create(
        :user,
        name: friendlist.first["name"],
        uid: friendlist.first["id"]
      )
      click_link "Your Upcoming Events"
      click_link event.name

      fill_in("search", with: friend.name)

      click_button("Invite Friends")
      expect(page).to have_content("You successfully added #{friend.name}")
    end

    scenario "event organizer invites invalid friend to event" do
      click_link "Your Upcoming Events"
      click_link event.name

      fill_in("search", with: "John Snow")

      click_button("Invite Friends")
      expect(page).to have_content("Your friend, John Snow is either not on the app, or already invited.")
    end

    scenario "event organizer invites friend twice to event" do
      friend = create(
        :user,
        name: friendlist.first["name"],
        uid: friendlist.first["id"]
      )

      click_link "Your Upcoming Events"
      click_link event.name

      fill_in("search", with: friend.name)
      click_button("Invite Friends")

      fill_in("search", with: friend.name)
      click_button("Invite Friends")

      expect(page).to have_content(
        "Your friend, #{friend.name} is either not on the app, or
        already invited."
      )
    end
  end
end
