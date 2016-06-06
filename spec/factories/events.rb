FactoryGirl.define do
  factory :event do
    name "Crazy Times"
    date Time.zone.now + 2.weeks
    start_time "10 : 00 PM"
    association :organizer, factory: :user
  end
end
