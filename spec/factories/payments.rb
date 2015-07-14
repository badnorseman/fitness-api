FactoryGirl.define do
  factory :payment do
    user
    amount 10000
    currency "USD"
    payment_method_nonce "fake-valid-nonce"
    product_id 1
  end

  # factory :valid_payment, class: Payment do
  # factory :invalid_payment, class: Payment do
  #   user
  #   amount 10000
  #   currency "USD"
  #   payment_method_nonce "fake-consumed-nonce"
  #   product_id 1
  # end
end
