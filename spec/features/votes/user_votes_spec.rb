require "rails_helper"
feature "user votes on venueselection", %{
  As a user
  I want to upvote and downvote a venueselection
  So my friends know what is interesting
}, js: true do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:facebook]
    Capybara.server_host= 'localhost' #this is the goal
    Capybara.server_port = 3000
    visit root_path
    find("#faceauth-link").click
  end

  context "as an authenticated event organizer" do
    let!(:current_user) { User.find_by(uid: "104163923349051") }
    let!(:koalafake) { KoalaFake.new(current_user.token) }
    let!(:date) { Time.zone.now + 1.week }
    let!(:friendlist) { koalafake.get_connections("me", "friends") }
    let!(:event) { create(:event, organizer: current_user, date: date) }
    let!(:vselect) { create(:venueselection, user: current_user, event: event) }

    scenario "event org sees up down arrows on selection and vote", js: false do
      click_link("Your Upcoming Events")
      click_link event.name

      expect(page).to have_css(".fa-chevron-down")
      expect(page).to have_css(".fa-chevron-up")
    end

    scenario "event org downvotes their selection" do
      find_link("Your Upcoming Events").trigger("click")
      click_link event.name

      find_link("down-vselect-#{vselect.id}").trigger("click")
      expect(page).to have_content("-1")
    end
  end

  context "as an authenticated event invitee" do
    let!(:current_user) { User.find_by(uid: "104163923349051") }
    let!(:koalafake) { KoalaFake.new(current_user.token) }
    let!(:date) { Time.zone.now + 1.week }
    let!(:frlst) { koalafake.get_connections("me", "friends") }
    let!(:friend) { create(:user, name: frlst[0]["name"], uid: frlst[0]["id"]) }
    let!(:event) { create(:event, organizer: friend, date: date) }
    let!(:vselect) { create(:venueselection, user: friend, event: event) }
    let!(:invite) { Invite.create(inviter: friend, invitee: current_user, event: event, status: "Attending") }
    let!(:c_u_vs) { create(:venueselection, user: current_user, event: event) }

    scenario "as an invitee I see buttons", js: false do
      click_link("Your Upcoming Events")
      click_link event.name
      expect(page).to have_css(".fa-chevron-down")
      expect(page).to have_css(".fa-chevron-up")
    end

    scenario "invitee upvotes event org venueselect" do
      find_link("Your Upcoming Events").trigger("click")
      click_link event.name

      find_link("up-vselect-#{vselect.id}").trigger("click")
      expect(page).to have_content("1")
    end

    scenario "invitee downvotes event org venueselect upvotes own selection" do
      find_link("Your Upcoming Events").trigger("click")
      click_link event.name

      find_link("down-vselect-#{vselect.id}").trigger("click")
      find_link("up-vselect-#{c_u_vs.id}").trigger("click")
      expect(page).to have_content("1")
      expect(page).to have_content("-1")
    end
  end
end
