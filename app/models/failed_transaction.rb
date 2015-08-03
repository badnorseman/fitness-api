class FailedTransaction
  attr_reader :errors

  def initialize(errors:)
    @errors = ActiveModel::Errors.new(self)
    @errors.add(:base, errors)
  end

  def id
    0
  end

  def persisted?
    false
  end
end
