class FailedPayment
  attr_reader :errors

  def initialize
    @errors = ActiveModel::Errors.new(self)
    @errors.add(:base, "Payment failed")
  end

  def id
    0
  end

  def persisted?
    false
  end
end
