FactoryGirl.define do
  factory :exercise_log do
    user
    coach
    exercise_description
    distance 100
    duration 45
    load 80.5
    repetition nil
    tempo "TEMPO"
  end
end
