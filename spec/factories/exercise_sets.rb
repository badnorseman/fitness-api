FactoryGirl.define do
  factory :exercise_set do
    user
    exercise_session
    sequence(:name) { |n| "NAME#{n}" }
    duration 45
  end
end
