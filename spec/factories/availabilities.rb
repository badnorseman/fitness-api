FactoryGirl.define do
  factory :availability do
    coach
    start_at                Time.zone.now.change(usec: 0)
    end_at                  Time.zone.now.change(usec: 0) + 4.weeks
    opening_time            Time.zone.parse("9:00AM")
    closing_time            Time.zone.parse("9:00PM")
    permitted_weekdays      ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    duration                60
    auto_confirmation       false
    cancellation_period     24
    late_cancellation_fee   50
    maximum_of_participants 1
    priority                1
  end
end
