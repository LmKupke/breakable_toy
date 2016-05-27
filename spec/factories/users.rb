FactoryGirl.define do
  sequence(:uid)      { |n| "100#{n}" }
  sequence(:email)    { |n| "person#{n}@example.com" }
  factory :user do
    email
    name "Jon Snow"
    password "direwolfGhost"
    password_confirmation "direwolfGhost"
    provider "facebook"
    uid "1234"
    photo "photo.png"
  end
end
