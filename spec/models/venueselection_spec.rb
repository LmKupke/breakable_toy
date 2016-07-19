require 'rails_helper'


RSpec.describe Venueselection, type: :model do

  it { should have_valid(:event_id).when(1) }
  it { should_not have_valid(:event_id).when(nil, '') }

  it { should have_valid(:venue_id).when(1) }
  it { should_not have_valid(:venue_id).when(nil, '') }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when(nil, '') }


  describe ".new" do
    it "should take dependencies" do
      event1 = create(:event)
      venue = create(:venue)
      venueselection = Venueselection.create(event: event1, user: event1.organizer, venue: venue)

      expect(venueselection.user.name).to eq("Jon Snow")
      expect(venueselection.event.name).to eq("Crazy Times")
      expect(venueselection.venue.name).to eq("Dillion's")
    end
  end
end
