FactoryGirl.define do
  factory :tag do
    user
    sequence(:name) { |n| "NAME#{n}" }
  end
end
