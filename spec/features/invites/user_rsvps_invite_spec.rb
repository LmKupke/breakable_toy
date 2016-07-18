require "rails_helper"

feature "user rsvps to event", %{
  As an invitee to an event
  I want to respond to an invitation
  So my friends know that I am attending
} do

  # Acceptance Criteria:
  # [ ] Invitations Link in Nav Bar
  # [ ] Buttons for Attending Event and Not Attending Event
  # [ ] Attending the Event shows message and appears in Upcoming Events
  # [ ] Not Attending the event shows message and
  # => doesn't appear in Upcoming Events

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    visit root_path
    find("#faceauth-link").click
  end

  context "current_user" do
    let(:current_user) { User.find_by(uid: "104163923349051") }
    let!(:koalafake) { KoalaFake.new(current_user.token, ENV['FB_APP_SECRET']) }
    let!(:friendlist) { koalafake.get_connections("me","friends")}
    let!(:friend) { create(:user, name: friendlist.first["name"],
      uid: friendlist.first["id"])
    }
    let!(:event) { create(:event, organizer: friend, name: "Friend Invite") }
    let!(:venueselection) { create(:venueselection, user: friend,
      event: event)
    }
    let!(:invite) { Invite.create(inviter: friend, invitee: current_user,
      event: event, status: "Pending")
    }

    scenario "a user sees rsvp buttons and inviter name" do
      click_link "Invitations"

      expect(page).to have_content(event.name)
      expect(page).to have_link(invite.inviter.name)
      expect(page).to have_button("Attending")
      expect(page).to have_button("Can't Attend")
    end

    scenario "a user attends the event" do
      click_link "Invitations"
      click_button "Attending"

      expect(page).to have_content("You are now attending the upcoming event.")
      expect(page).to_not have_content(invite.inviter.name)
      expect(page).to_not have_content(invite.event.name)
    end

    scenario "a user attends the event and sees it in upcoming events" do
      click_link "Invitations"
      click_button "Attending"
      click_link "Your Upcoming Events"

      expect(page).to have_content(invite.inviter.name)
      expect(page).to have_link(invite.event.name)
    end

    scenario "a user declines the event" do
      click_link "Invitations"
      click_button "Can't Attend"

      expect(page).to have_content("You declined the invitation to the event.")
      expect(page).to_not have_content(invite.inviter.name)
      expect(page).to_not have_content(invite.event.name)
    end

    scenario "a user declines the event invite & it isnt in upcoming events" do
      click_link "Invitations"
      click_button "Can't Attend"
      click_link "Your Upcoming Events"

      expect(page).to_not have_content(invite.inviter.name)
      expect(page).to_not have_link(invite.event.name)
    end
  end
end
