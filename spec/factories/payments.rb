FactoryGirl.define do
  factory :payment do
    user
    amount 10000
    currency "USD"
    payment_method_nonce "PAYMENT_METHOD_NONCE"
    product_id 1
  end
end
