class CreateBooking
  def initialize(user:, params:)
    @user = user
    @coach_id = params.fetch(:coach_id)
    @start_at = params.fetch(:start_at)
    @end_at = params.fetch(:end_at)
  end

  def call
    return FailedBooking.new if unavailable?

    Booking.create(booking_params) do |booking|
      booking.user = @user
      booking.confirmed_at = Time.zone.now if auto_confirmed?
    end
  end

  private

  def auto_confirmed?
    availability.auto_confirmation
  end

  def available?
    VerifyAvailability.new(coach_id: @coach_id,
                           start_at: @start_at,
                           end_at: @end_at,
                           maximum_of_participants: availability.maximum_of_participants).call
  end

  def unavailable?
    !available?
  end

  def availability
    SearchAvailabilityByDates.new(coach_id: @coach_id, start_at: @start_at, end_at: @end_at).call
  end

  def booking_params
    { coach_id: @coach_id, start_at: @start_at, end_at: @end_at }
  end
end
