require "rails_helper"

feature "user asks to join event", %{
  As an authenticated user
  I want to ping a friend eventorg
  So that they can add me to their event
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
    let!(:current_user) { User.find_by(uid: "104163923349051") }
    let!(:a) { KoalaFake.new(current_user.token) }
    let!(:friendlist) { a.get_connections("me","friends") }
    let!(:friend) { create(
      :user,
      name: friendlist.first["name"],
      uid: friendlist.first["id"]
    ) }

    let!(:newsfeedevent) {
      create(:event,organizer: friend, name: "NewsFeed Event", date: Time.zone.now + 1.week)
    }

    scenario "user logs in and sees newsfeed" do
      click_link "Home"

      expect(page).to have_content(newsfeedevent.name)
    end

    scenario "user and event org don't have phone number" do
      click_link "Home"
      click_button("Ask to Tag along!")

      expect(page).to have_content("Your phonenumber
        and #{newsfeedevent.organizer.name}'s number is not saved!"
      )
    end

    scenario "current user's phonenumber not saved" do
      friend.phonenumber = "1111112222"
      friend.save
      click_link "Home"
      click_button("Ask to Tag along!")

      expect(page).to have_content("Your phonenumber is not saved!
        Please add your number so you can ping
        the #{newsfeedevent.organizer.name}. To add your phonenumber go to your
        profile!"
      )
    end

    scenario "eventorgs's phonenumber not saved" do
      current_user.phonenumber = "1111112222"
      current_user.save
      click_link "Home"
      click_button("Ask to Tag along!")

      expect(page).to have_content("Seems like #{newsfeedevent.organizer.name}
        doesn't have their number on NOMO-FOMO.
        Text them and let them know to added it."
      )
    end
    scenario "eventorgs's and current_user phonenumber saved sends text" do
      current_user.phonenumber = "1111112222"
      friend.phonenumber = "3334445555"
      friend.save
      current_user.save
      click_link "Home"
      click_button("Ask to Tag along!")

      expect(page).to have_content("You have sent a text
        to #{newsfeedevent.organizer.name} about joining the event!"
      )
      expect(FakeSMS.messages.count).to eq(1)
      expect(FakeSMS.messages.first.from[:body]).to eq(
        "Your friend #{current_user.name} wants to join your Event, #{newsfeedevent.name} on NOMO-FOMO! Invite them to it!"
      )
      expect(page).to_not have_button("Ask to Tag along!")
    end
  end
end
