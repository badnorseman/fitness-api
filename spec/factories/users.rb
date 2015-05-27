FactoryGirl.define do
  factory :administrator, class: User do
    sequence(:uid) { |n| "admin#{n}@fitbird.com" }
    name "administrator"
    first_name "administrator"
    last_name "fitbird"
    provider "email"
    sequence(:email) { |n| "admin#{n}@fitbird.com" }
    password "Test1234"
    roles ["user", "coach", "administrator"]
  end

  factory :coach, class: User do
    sequence(:uid) { |n| "coach#{n}@fitbird.com" }
    name "coach"
    first_name "coach"
    last_name "fitbird"
    provider "email"
    sequence(:email) { |n| "coach#{n}@fitbird.com" }
    password "Test1234"
    roles ["user", "coach"]
  end

  factory :user do
    sequence(:uid) { |n| "user#{n}@fitbird.com" }
    name "user"
    first_name "user"
    last_name "fitbird"
    provider "email"
    sequence(:email) { |n| "user#{n}@fitbird.com" }
    password "Test1234"
    roles ["user"]
  end
end
