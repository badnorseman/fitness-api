require "rails_helper"

describe Identity, type: :model do
  it "has a valid factory" do
    identity = build(:identity)
    expect(identity).to be_valid
  end
end
