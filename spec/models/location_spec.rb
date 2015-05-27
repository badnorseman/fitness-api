require "rails_helper"

describe Location, type: :model do
  it "has a valid factory" do
    location = build(:location)
    expect(location).to be_valid
  end
end
