FactoryGirl.define do
  factory :administrator, class: User do
    sequence(:uid) { |n| "admin#{n}@fitbird.com" }
    provider "email"
    sequence(:token) { |n| "token#{n}" }
    sequence(:email) { |n| "admin#{n}@fitbird.com" }
    administrator true
    name "administrator"
  end

  factory :coach, class: User do
    sequence(:uid) { |n| "coach#{n}@fitbird.com" }
    provider "email"
    sequence(:token) { |n| "token#{n}" }
    sequence(:email) { |n| "coach#{n}@fitbird.com" }
    coach true
    name "coach"
  end

  factory :user do
    sequence(:uid) { |n| "user#{n}@fitbird.com" }
    provider "email"
    sequence(:token) { |n| "token#{n}" }
    sequence(:email) { |n| "user#{n}@fitbird.com" }
    name "user"
  end
end
