FactoryGirl.define do
  factory :administrator, class: User do
    sequence(:uid) { |n| "admin#{n}@fitbird.com" }
    provider "email"
    sequence(:token) { |n| "token#{n}" }
    first_name "administrator"
    last_name "fitbird"
    roles ["user", "coach", "administrator"]
  end

  factory :coach, class: User do
    sequence(:uid) { |n| "coach#{n}@fitbird.com" }
    provider "email"
    sequence(:token) { |n| "token#{n}" }
    first_name "coach"
    last_name "fitbird"
    roles ["user", "coach"]
  end

  factory :user do
    sequence(:uid) { |n| "user#{n}@fitbird.com" }
    provider "email"
    sequence(:token) { |n| "token#{n}" }
    first_name "user"
    last_name "fitbird"
    roles ["user"]
  end
end
