require "rails_helper"

describe Weekday do
  it "should have permitted weekdays" do
    weekdays = ["MONDAY", "tuesday"]

    expect(Weekday.new(permitted: weekdays).permitted).to include("monday", "tuesday")
  end

  it "should have unpermitted weekdays" do
    weekdays = ["MONDAY", "tuesday"]

    expect(Weekday.new(permitted: weekdays).unpermitted).to include("wednesday", "thursday", "friday", "saturday", "sunday")
  end

  it "should filter invalid weekdays" do
    weekdays = ["MOONDAY", "tuesday"]

    expect(Weekday.new(permitted: weekdays).permitted).not_to include("MOONDAY")
  end
end
