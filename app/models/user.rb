class User < ActiveRecord::Base
  scope :data_for_listing, -> { select(:id, :uid, :administrator, :coach, :name, :email, :gender, :birth_date) }

  has_secure_token
  has_attached_file :avatar, styles: { thumb: "620x620>", normal: "1860x620!" }

  has_one  :location, dependent: :destroy
  has_many :availabilities, class_name: :Availability, foreign_key: :coach_id, dependent: :destroy
  has_many :bookings, class_name: :Booking, foreign_key: :coach_id
  has_many :exercise_descriptions, dependent: :destroy
  has_many :exercise_plans, dependent: :destroy
  has_many :habit_descriptions, dependent: :destroy
  has_many :habit_descriptions, through: :habit_logs
  has_many :habit_logs, dependent: :destroy
  has_many :payment_plans
  has_many :products, dependent: :destroy
  has_many :tags
  has_many :transactions

  # Validate attributes
  validates :uid,
            :provider,
            presence: true

  validates_attachment :avatar,
    content_type: { content_type: [/image\/jpeg/, /image\/png/] },
    file_name: { matches: [/jpeg/, /jpg/, /png/] }

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
      user.email = auth.info.fetch("email")
      user.name = auth.info.fetch("name")
    end
  end
end
