require "spec_helper"

describe Scheduler::DailySchedule do
  before do
    @availability = create(:availability)
    @daily_schedule = Scheduler::DailySchedule.new(availability: @availability, date: @availability.start_at.to_date).to_hash
  end

  it "should include time" do
    time = @availability.opening_time

    expect(@daily_schedule[time]).to be_truthy
  end

  it "shouldn't include time" do
    time = @availability.closing_time + @availability.duration

    expect(@daily_schedule[time]).to be_falsey
  end

  it "should have exact times" do
    times = ((@availability.closing_time - @availability.opening_time) /
              1.minute /
              @availability.duration).to_i

    expect(@daily_schedule.count).to eq(times)
  end
end
