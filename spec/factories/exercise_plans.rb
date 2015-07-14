FactoryGirl.define do
  factory :exercise_plan do
    user
    sequence(:name) { |n| "NAME#{n}" }
    sequence(:description) { |n| "DESCRIPTION#{n}" }
  end
end
