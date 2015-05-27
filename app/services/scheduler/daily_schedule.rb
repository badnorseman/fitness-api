module Scheduler
  class DailySchedule
    def initialize(availability:, date:)
      @availability = availability
      @date = date.to_datetime
    end

    def to_hash
      times.each_with_object({}) do |time, daily_schedule|
        daily_schedule[time] = HourlySchedule.new(availability: @availability, time: time).to_hash
      end
    end

    def has_times?
      @availability.available_on?(@date)
    end

    private

    def times
      (beginning_of_daily_schedule..end_of_daily_schedule).step(@availability.duration.minutes).map do |timestamp|
        Time.zone.at timestamp
      end
    end

    def beginning_of_daily_schedule
      @date.change(hour: @availability.opening_time.strftime("%H").to_i,
                   minute: @availability.opening_time.strftime("%M").to_i).to_i
    end

    def end_of_daily_schedule
      @date.change(hour: @availability.closing_time.strftime("%H").to_i,
                   minute: @availability.closing_time.strftime("%M").to_i).to_i - @availability.duration.minutes
    end
  end
end
