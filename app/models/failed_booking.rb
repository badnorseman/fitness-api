class FailedBooking
  attr_reader :errors

  def initialize
    @errors = ActiveModel::Errors.new(self)
    @errors.add(:base, "Time is no longer available")
  end

  def id
    0
  end

  def persisted?
    false
  end
end
