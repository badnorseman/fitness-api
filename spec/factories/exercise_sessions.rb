FactoryGirl.define do
  factory :exercise_session do
    user
    exercise_plan
    sequence(:name) { |n| "NAME#{n}" }
  end
end
