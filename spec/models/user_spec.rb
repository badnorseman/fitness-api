require 'spec_helper'

describe User, type: :model do
  it "has a valid factory for administrator" do
    user = build(:administrator)
    expect(user).to be_valid
  end

  it "has a valid factory for coach" do
    user = build(:coach)
    expect(user).to be_valid
  end

  it "has a valid factory for user" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "has a invalid factory for user" do
    user = build(:user, roles: [])
    expect(user).to be_invalid
  end
end
