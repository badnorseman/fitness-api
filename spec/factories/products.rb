FactoryGirl.define do
  factory :product do
    user
    sequence(:name) { |n| "NAME#{n}" }
    sequence(:description) { |n| "DESCRIPTION#{n}" }
    currency "USD"
    price 10000
  end
end
