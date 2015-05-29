FactoryGirl.define do
  factory :identity do
    # sequence(:email) { |n| "admin#{n}@fitbird.com" }
    # password "Test1234"
    # sequence(:email) { |n| "coach#{n}@fitbird.com" }
    # password "Test1234"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "test"
  end
end
