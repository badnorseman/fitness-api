class SearchAvailabilityByDates
  def initialize(coach_id:, start_at:, end_at:)
    @coach = coach_id
    @date = start_at.to_date
    @start_time = start_at.to_time
    @end_time = end_at.to_time
    @weekday = "{#{start_at.to_date.strftime("%A").downcase}}"
  end

  def call
    availability || NullAvailability.new
  end

  private

  def availability
    Availability.order(priority: :desc).
                 find_by("coach_id = ? AND
                         start_at <= ? AND
                         end_at >= ? AND
                         opening_time <= ? AND
                         closing_time >= ? AND
                         NOT unpermitted_weekdays @> ?",
                         @coach,
                         @date,
                         @date,
                         @start_time,
                         @end_time,
                         @weekday)
  end
end
