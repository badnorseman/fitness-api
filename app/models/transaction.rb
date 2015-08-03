class Transaction < ActiveRecord::Base
  belongs_to :user

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :amount,
            :currency,
            presence: true

  def product_id
  end

  def product_id=(value)
  end

  def payment_method_nonce
  end

  def payment_method_nonce=(value)
  end
end
