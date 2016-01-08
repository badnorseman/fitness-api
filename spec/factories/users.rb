FactoryGirl.define do
  factory :administrator, class: User do
    sequence(:uid) { |n| "ADMINISTRATOR#{n}@FITBIRD.COM" }
    provider "identity"
    name "ADMINISTRATOR"
    administrator true
    coach false
  end

  factory :coach, class: User do
    sequence(:uid) { |n| "COACH#{n}@FITBIRD.COM" }
    provider "identity"
    name "COACH"
    administrator false
    coach true
  end

  factory :user do
    sequence(:uid) { |n| "USER#{n}@FITBIRD.COM" }
    provider "identity"
    name "USER"
    administrator false
    coach false
  end
end
