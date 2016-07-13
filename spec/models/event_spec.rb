require 'rails_helper'


RSpec.describe Event, type: :model do
  it { should have_valid(:name).when("Crazy Fun Lazer Tag Party", "Night OUt") }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:date).when(Time.zone.now + 1.minute) }
  it { should_not have_valid(:date).when(nil, "10/23/15 13:00") }

  it { should have_valid(:start_time).when("9 : 00 AM", "10 : 30 PM") }
  it { should_not have_valid(:start_time).when(nil, "10:30PM") }

  it { should have_valid(:organizer_id).when(1) }
  it { should_not have_valid(:organizer_id).when(nil) }

  describe '#fix_datetime' do
    it "append the correct date and time to the database entry" do
      event = build(:event, date: Time.zone.now.beginning_of_day)
      event.fix_datetime

      expect(event.date).to eq(Time.zone.now.beginning_of_day + 22.hours + 1.minute)
    end
  end

  describe "#upcoming" do
    it "should return an array of upcoming events" do
      user = create(:user)
      event1 = create(:event, name: "Event 1", organizer: user)
      event2 = create(:event, name: "Event 2", organizer: user)
      expect(Event.upcoming(user)).to eq([event1,event2])
    end
  end

  describe "#past_events" do
    it "should return an array of past events" do
      user = create(:user)
      event1 = build(:event, name: "Event 1", organizer: user, date: Time.zone.now.beginning_of_day - 2.weeks)
      event2 = build(:event, name: "Event 2", organizer: user, date: Time.zone.now.beginning_of_day - 1.weeks)

      event1.save(validate: false)
      event2.save(validate: false)

      expect(Event.past_events(user)).to eq([event2,event1])
    end
  end
end
