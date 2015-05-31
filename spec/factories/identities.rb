FactoryGirl.define do
  factory :identity do
    sequence(:email) { |n| "123#{n}@test.com" }
    password "123test"
  end
end
