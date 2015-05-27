FactoryGirl.define do
  factory :payment do
    user
    payment_plan
    sequence(:transaction_id) { |n| "Transaction#{n}" }
    sequence(:customer_id) { |n| "Customer#{n}" }
  end
end
