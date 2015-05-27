class Location < ActiveRecord::Base
  belongs_to :user

  # Validate attributes
  validates :company, length: {maximum: 100}
  validates :address_line1, presence: true, length: {maximum: 100}
  validates :address_line2, length: {maximum: 100}
  validates :postal_code, length: {maximum: 20}
  validates :city, presence: true, length: {maximum: 100}
  validates :state_province, length: {maximum: 100}
  validates :country, presence: true, length: {maximum: 100}
  validates :phone_number, length: {maximum: 20}
end
