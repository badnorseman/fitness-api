FactoryGirl.define do
  factory :transaction do
    user
    amount { rand(1..1899) }
    currency "USD"
    sequence(:customer) { |n| "CUSTOMER#{n}" }
    sequence(:merchant) { |n| "MERCHANT#{n}" }
    sequence(:product) { |n| "PRODUCT#{n}" }
    payment_method_nonce "fake-valid-nonce"

    trait :consumed_nonce do
      amount { rand(3001..4000) }
      payment_method_nonce "fake-consumed-nonce"
    end
  end
end
