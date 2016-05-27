require 'rails_helper'

RSpec.describe Venue, type: :model do

  it { should have_valid(:name).when("Dillion's", "T's Pub") }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:phone).when("1234567890", "1112223333") }
  it { should_not have_valid(:phone).when(nil, '', "12345678", "12345678901") }

  it { should have_valid(:category).when("Dace Club", "Lounge") }
  it { should_not have_valid(:category).when(nil, '') }

  it { should have_valid(:address).when("123 Main St.","L St.") }
  it { should_not have_valid(:address).when(nil, "", "St") }

  it { should have_valid(:city).when("Boston", "Cambridge") }
  it { should_not have_valid(:city).when(nil, '') }

  it { should have_valid(:postal_code).when("02115", "30327") }
  it { should_not have_valid(:postal_code).when(nil, '011111', '', '1') }

  it { should have_valid(:state_code).when("MA", "GA") }
  it { should_not have_valid(:state_code).when(nil, 'Massachusetts', '', 'Georgia') }

  it { should have_valid(:rating).when(1, 3.5, 5) }
  it { should_not have_valid(:rating).when(nil, 6, -1) }

  describe '#full_address' do
    it 'returns a string of the address' do
      venue = create(:venue)
      expect(venue.full_address).to eq("955 Boylston St Boston, MA 02115")
    end
  end
end
