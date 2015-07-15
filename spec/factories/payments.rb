FactoryGirl.define do
  factory :payment do
    user
    amount 10000
    currency "USD"
    payment_method_nonce "fake-valid-nonce"
    product_id 1

    trait :consumed_nonce do
      payment_method_nonce "fake-consumed-nonce"
    end
  end
end
