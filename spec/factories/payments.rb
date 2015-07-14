FactoryGirl.define do
  factory :payment do
    user
    amount 10000
    currency "USD"
  end
end
