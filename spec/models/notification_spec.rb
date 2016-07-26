require "rails_helper"

RSpec.describe Notification, type: :model do
  it { should have_valid(:event_id).when(1) }
  it { should_not have_valid(:event_id).when(nil) }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when(nil) }

  it { should have_valid(:ping).when(true) }
  it { should_not have_valid(:ping).when(nil) }
end
