class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  scope :data_for_listing, -> { select(:id, :uid, :name, :email, :roles) }

  has_one  :location, dependent: :destroy
  has_many :availabilities, class: Availability, foreign_key: :coach_id, dependent: :destroy
  has_many :bookings, class: Booking, foreign_key: :coach_id
  has_many :exercise_descriptions
  has_many :exercise_plans
  has_many :habit_descriptions
  has_many :habit_descriptions, through: :habit_logs
  has_many :habit_logs, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :payment_plans, through: :payments
  has_many :payment_plans
  has_many :products
  has_many :tags

  # Validate attributes
  # validates :first_name, presence: true, length: {maximum: 100}
  # validates :last_name,  presence: true, length: {maximum: 100}
  # validates :gender, presence: true, length: {maximum: 1}
  # validates :birth_date, presence: true
  # validates :height, presence: true
  # validates :weight, presence: true
  # validates :roles, presence: true

  before_create :skip_confirmation!

  def as_json(options={})
    UserSerializer.new(self).as_json(options)
  end

  def administrator?
    self.roles.include?("administrator")
  end

  def coach?
    self.roles.include?("coach")
  end

  def user?
    self.roles.include?("user")
  end
end
