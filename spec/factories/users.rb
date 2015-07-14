FactoryGirl.define do
  factory :administrator, class: User do
    sequence(:uid) { |n| "ADMINISTRATOR#{n}@FITBIRD.COM" }
    provider "email"
    sequence(:email) { |n| "ADMINISTRATOR#{n}@FITBIRD.COM" }
    administrator true
    name "ADMINISTRATOR"
  end

  factory :coach, class: User do
    sequence(:uid) { |n| "COACH#{n}@FITBIRD.COM" }
    provider "email"
    sequence(:email) { |n| "COACH#{n}@FITBIRD.COM" }
    coach true
    name "COACH"
  end

  factory :user do
    sequence(:uid) { |n| "USER#{n}@FITBIRD.COM" }
    provider "email"
    sequence(:email) { |n| "USER#{n}@FITBIRD.COM" }
    name "USER"
  end
end
