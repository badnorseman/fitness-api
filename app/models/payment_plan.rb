class PaymentPlan < ActiveRecord::Base
  belongs_to :user

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :currency, presence: true, length: { maximum: 3 }
  validates :price,
            :billing_day_of_month,
            :number_of_billing_cycles,
            :billing_frequency,
            presence: true
end
