FactoryGirl.define do
  factory :administrator, class: User do
    sequence(:uid) { |n| "ADMINISTRATOR#{n}@FITBIRD.COM" }
    provider "email"
    sequence(:email) { |n| "ADMINISTRATOR#{n}@FITBIRD.COM" }
    name "ADMINISTRATOR"
    administrator true
    coach false
  end

  factory :coach, class: User do
    sequence(:uid) { |n| "COACH#{n}@FITBIRD.COM" }
    provider "email"
    sequence(:email) { |n| "COACH#{n}@FITBIRD.COM" }
    name "COACH"
    administrator false
    coach true
  end

  factory :user do
    sequence(:uid) { |n| "USER#{n}@FITBIRD.COM" }
    provider "email"
    sequence(:email) { |n| "USER#{n}@FITBIRD.COM" }
    name "USER"
    administrator false
    coach false
  end
end
