class Payment < ActiveRecord::Base
  belongs_to :user

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :amount,
            :currency,
            presence: true
end
