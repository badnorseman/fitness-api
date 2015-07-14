FactoryGirl.define do
  factory :exercise_plan_log do
    user
    coach
    sequence(:name) { |n| "NAME#{n}" }
    sequence(:note) { |n| "NOTE#{n}" }
  end
end
