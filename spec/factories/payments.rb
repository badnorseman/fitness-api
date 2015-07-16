FactoryGirl.define do
  factory :payment do
    user
    product_id 1
    amount { rand(1..1899) }
    currency "USD"
    payment_method_nonce "fake-valid-nonce"

    trait :consumed_nonce do
      amount { rand(3001..4000) }
      payment_method_nonce "fake-consumed-nonce"
    end
  end
end
