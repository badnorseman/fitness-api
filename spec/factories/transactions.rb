FactoryGirl.define do
  factory :transaction do
    user
    amount { rand(1..1899) }
    currency "USD"
    sequence(:customer_name) { |n| "CUSTOMER_NAME#{n}" }
    sequence(:merchant_name) { |n| "MERCHANT_NAME#{n}" }
    sequence(:product_name) { |n| "PRODUCT_NAME#{n}" }
    payment_method_nonce "fake-valid-nonce"

    trait :consumed_nonce do
      amount { rand(3001..4000) }
      payment_method_nonce "fake-consumed-nonce"
    end
  end
end
