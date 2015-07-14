FactoryGirl.define do
  factory :habit_description do
    user
    sequence(:name) { |n| "NAME#{n}" }
    sequence(:summary) { |n| "SUMMARY#{n}" }
    sequence(:description) { |n| "DESCRIPTION#{n}" }
  end
end
