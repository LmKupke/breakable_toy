require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_valid(:name).when("Crazy Fun Lazer Tag Party", "Night OUt") }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:date).when("2016-05-31T13:44:55-04:00") }
  it { should_not have_valid(:date).when(nil, "10/23/15 13:00") }

end
