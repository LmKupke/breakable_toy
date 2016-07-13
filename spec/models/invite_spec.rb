require 'rails_helper'

RSpec.describe Invite, type: :model do
  it { should have_valid(:inviter_id).when(1, 2) }
  it { should_not have_valid(:inviter_id).when(nil, '') }

  it { should have_valid(:invitee_id).when(1, 2) }
  it { should_not have_valid(:invitee_id).when(nil, '') }

  it { should have_valid(:event_id).when(1, 2) }
  it { should_not have_valid(:event_id).when(nil, '') }

  it { should have_valid(:status).when("Pending", "Attending", "Not Attending") }
  it { should_not have_valid(:status).when(nil, '', "Other response") }


  describe "#upcomingpend" do
    it "returns an array of Invites sorted by date" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      event2 = create(:event, name: "Event 2", organizer: friend, date: Time.zone.now + 1.week)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user)
      invite2 = Invite.create(event: event2, inviter: friend, invitee: user)

      expect(Invite.upcomingpend(user)).to eq([invite2,invite1])
    end
  end

  describe "#attending?" do

    it "returns true when Invite status is Attending" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user, status: "Attending")
      expect(invite1.attending?).to eq(true)
    end

    it "returns false when Invite status is not Attending" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user, status: "Pending")
      expect(invite1.attending?).to eq(false)
    end
  end

  describe "#missing_out?" do
    it "returns true when Invite status is Not Attending" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user, status: "Not Attending")
      expect(invite1.missing_out?).to eq(true)
    end

    it "returns false when Invite status is not Not Attending" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user, status: "Attending")
      expect(invite1.missing_out?).to eq(false)
    end
  end

  describe "#pending?" do
    it "returns true when Invite status is Pending" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user, status: "Pending")
      expect(invite1.pending?).to eq(true)
    end

    it "returns false when Invite status is not Pending" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user, status: "Not Attending")
      expect(invite1.pending?).to eq(false)
    end
  end

  describe "#user_attending?" do
    it "returns true if user invited and attending" do
      user = create(:user)
      friend = create(:user)
      event1 = create(:event, name: "Event 1", organizer: friend, date: Time.zone.now + 2.weeks)
      invite1 = Invite.create(event: event1, inviter: friend, invitee: user, status: "Not Attending")
    end

    it "returns false if array empty" do

    end
  end

  describe "#user_notattending?" do
    it "returns true if user invited and not attending" do

    end

    it "returns false if array empty" do

    end
  end
  describe "#user_notinvited?" do
    it "returns true if user has no invites" do

    end

    it "returns false if user has invites" do

    end
  end
end
