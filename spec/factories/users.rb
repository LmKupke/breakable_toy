FactoryGirl.define do
  factory :user do
    name "Jon Snow"
    sequence(:email) { |n| "knightswatch#{n}@wall.com" }
    password "direwolfGhost"
    password_confirmation "direwolfGhost"
    provider "facebook"
    uid "1234"
    photo "photo.png"
  end
end
