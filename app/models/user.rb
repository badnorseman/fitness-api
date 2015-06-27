class User < ActiveRecord::Base
  has_secure_token
  has_attached_file :avatar, styles: {
    thumb: "100x100>",
    square: "200x200#",
    medium: "300x300>"
  }

  scope :data_for_listing, -> { select(:id, :email, :administrator, :coach, :name) }

  has_one  :location, dependent: :destroy
  has_many :availabilities, class_name: :Availability, foreign_key: :coach_id, dependent: :destroy
  has_many :bookings, class_name: :Booking, foreign_key: :coach_id
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
  validates :uid,
            :provider,
            presence: true

  validates :avatar,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }

  def as_json(options={})
    UserSerializer.new(self).as_json(options)
  end

  def administrator?
    self.administrator
  end

  def coach?
    self.coach
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
end
