require "spec_helper"

describe ExerciseSession, type: :model do
  it "has a valid factory" do
    exercise_session = build(:exercise_session)
    expect(exercise_session).to be_valid
  end

  it "should validate name length" do
    exercise_session = build(:exercise_session,
                             name: "EXCEEDS MAX LENGTH" * 10)
    expect(exercise_session).to be_invalid
  end
end
