require "rails_helper"

describe Availability, type: :model do
  it "has a valid factory" do
    availability = build(:availability)
    expect(availability).to be_valid
  end

  it "should have start at to be before end at" do
    availability = build(:availability,
                         start_at: Time.zone.now,
                         end_at: 1.day.ago)
    expect(availability).to be_invalid
  end

  it "should have opening time to be before closing time" do
    availability = build(:availability,
                         opening_time: Time.zone.parse("3:00PM"),
                         closing_time: Time.zone.parse("1:00PM"))
    expect(availability).to be_invalid
  end

  it "should have valid permitted weekdays only" do
    availability = build(:availability,
                         permitted_weekdays: ["MOONDAY", "tuesday"])
    expect(availability.permitted_weekdays).not_to include("MOONDAY")
  end

  it "should have unpermitted weekdays" do
    availability = build(:availability,
                         permitted_weekdays: ["MONDAY", "tuesday"])
    expect(availability.unpermitted_weekdays).to include("wednesday", "thursday", "friday", "saturday", "sunday")
  end
end
