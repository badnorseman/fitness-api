class CountBookings
  def initialize(coach_id:, start_at:, end_at:)
    @coach = coach_id
    @start_at = start_at
    @end_at = end_at
  end

  def call
    Booking.where("coach_id = ? AND
                  start_at < ? AND
                  end_at  > ?",
                  @coach,
                  @end_at,
                  @start_at).
                  count
  end
end
