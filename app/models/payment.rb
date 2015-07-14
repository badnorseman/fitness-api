class Payment < ActiveRecord::Base
  belongs_to :user

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :amount,
            :currency,
            presence: true

  # Should I call CreateClientToken here instead?
  def payment_method_nonce
  end

  def payment_method_nonce=(value)
  end
end
