require "rails_helper"

feature "user views newsfeed", %{
  As an authenticated user
  I want to see current upcoming events that friends have organized
  So that I can ask to join them
} do
  # Acceptance Criteria:
  # [ ] User is redirected newsfeed after login
  # [ ] Newsfeed contains a list of friends' upcoming events
  # [ ] Each event will contain the friend name and avatar
  # [ ] Clicking on an event will take me to the event show page

  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end

  context "current_user" do
    let(:current_user) { User.find_by(uid: "104163923349051") }

    scenario "user logs in and sees newsfeed" do
      a = KoalaFake.new(current_user.token, ENV["FB_APP_SECRET"])
      friendlist = a.get_connections("me","friends")

      friend =
      create(
        :user,
        name: friendlist.first["name"],
        uid: friendlist.first["id"]
      )

      newsfeedevent =
      create(
        :event,
        organizer: friend,
        name: "NewsFeed Event",
        date: Time.zone.now + 1.week
      )

      invite = Invite.create(
        invitee: current_user,
        inviter: friend,
        event: newsfeedevent
      )

      click_link "Home"
      expect(page).to have_content(newsfeedevent.name)
    end
  end
end
