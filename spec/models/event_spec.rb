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

  describe 'fix_datetime' do
    it "append the correct date and time to the database entry" do
      event = build(:event, date: Time.zone.now.beginning_of_day)
      event.fix_datetime

      expect(event.date).to eq(Time.zone.now.beginning_of_day + 22.hours + 1.minute)
    end
  end
end
