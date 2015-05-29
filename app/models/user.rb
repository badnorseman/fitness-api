class User < ActiveRecord::Base
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

  before_validation :generate_token, on: :create

  # Validate attributes
  validates :uid,
            :provider,
            :first_name,
            :last_name,
            :roles, presence: true

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

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth.fetch("provider"), auth.fetch("uid")) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.fetch("provider")
      user.uid = auth.fetch("uid")
    end
  end

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end
