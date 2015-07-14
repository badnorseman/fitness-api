FactoryGirl.define do
  factory :identity do
    sequence(:email) { |n| "USER#{n}@FITBIRD.COM" }
    password "PASSWORD"
  end
end
