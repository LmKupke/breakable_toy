require 'rails_helper'

feature 'user views profile', %Q{
  As an authenticated user
  I want to see my profile
  So that I can see my past events and invites
} do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end

  context "current_user" do
    let(:current_user) { User.find_by(uid: "104163923349051") }

    scenario "views their own profile" do
      first_event = create(:event, organizer: current_user,
        date: Time.zone.now.beginning_of_day + 1.week, name: "First Event")
      second_event = create(:event, organizer: current_user, name: "Second Event")

      click_link current_user.name
      expect(page).to have_link("First Event")
      expect(page).to have_content(first_event.start_time)
      expect(page).to have_link("Second Event")
      expect(page).to have_content(second_event.start_time)
    end

    scenario "views friends profile and see recent Past Events" do
      a = KoalaFake.new(current_user.token, ENV['FB_APP_SECRET'])
      friendlist = a.get_connections("me","friends")
      friend = create(:user, name: friendlist.first["name"], uid: friendlist.first["id"])
      newsfeedevent = create(:event, organizer: friend,
        name: "NewsFeed Event", date: Time.zone.now + 1.week)

      invite = Invite.create(invitee: current_user, inviter: friend,
        event: newsfeedevent)

      past_friend_event1 = build(:event, organizer: friend,
        name: "Most recent", date: Time.zone.now - 1.hour)

      past_friend_event2 = build(:event, organizer: friend,
        name: "Later Event", date: Time.zone.now - 2.hours)

      past_friend_event1.save(validate: false)
      past_friend_event2.save(validate: false)

      click_link "Invitations"
      click_link friend.name
      expect(page).to have_link(past_friend_event1.name)
      expect(page).to have_link(past_friend_event2.name)
    end
  end
end
