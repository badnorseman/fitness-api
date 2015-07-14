FactoryGirl.define do
  factory :payment_plan do
    user
    sequence(:name) { |n| "NAME#{n}" }
    sequence(:description) { |n| "DESCRIPTION#{n}" }
    currency "USD"
    price 10000
    billing_day_of_month "1"
    billing_frequency 1
    number_of_billing_cycles 3
  end
end
