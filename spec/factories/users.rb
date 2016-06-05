FactoryGirl.define do
  sequence(:uid)      { |n| "100#{n}" }
  sequence(:email)    { |n| "person#{n}@example.com" }
  sequence(:token)    { |n| "$2a$04$iYyVoLaz.NaKk78uxOqJuOFEpi8f/JqwwzNym.nTo5KL9S1VpAev#{n}" }
  factory :user do
    email
    name "Jon Snow"
    password "direwolfGhost"
    password_confirmation "direwolfGhost"
    provider "facebook"
    uid
    photo "photo.png"
    timezone (-4)
    token
    expires_at (324234)
  end
end
