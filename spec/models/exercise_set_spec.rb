require "spec_helper"

describe ExerciseSet, type: :model do
  it "has a valid factory" do
    exercise_set = build(:exercise_set)
    expect(exercise_set).to be_valid
  end

  it "should validate name length" do
    exercise_set = build(:exercise_set,
                         name: "EXCEEDS MAX LENGTH" * 10)
    expect(exercise_set).to be_invalid
  end
end
