class Availability < ActiveRecord::Base
  scope :future, -> { where("end_at >= ?", Time.zone.now) }
  scope :sort_by_priority, -> { order(priority: :asc) }

  belongs_to :coach, class: User

  # Validate associations
  validates :coach, presence: true

  # Validate attributes
  validates :start_at,
            :end_at,
            :opening_time,
            :closing_time,
            :permitted_weekdays,
            :duration,
            :cancellation_period,
            :late_cancellation_fee,
            presence: true

  validate :opening_time_before_closing_time
  validate :start_at_before_end_at

  def available_on?(date)
    permitted_weekdays.include?(date.strftime("%A").downcase)
  end

  def permitted_weekdays
    Weekday.new(unpermitted: self.unpermitted_weekdays).permitted
  end

  def permitted_weekdays=(days)
    self.unpermitted_weekdays = Weekday.new(permitted: days).unpermitted
  end

  private

  def start_at_before_end_at
    if start_at &&
      end_at &&
      start_at > end_at
      errors.add(:start_at, "can't be after End At")
    end
  end

  def opening_time_before_closing_time
    if opening_time >= closing_time
      errors.add(:opening_time, "must be before Closing Time")
    end
  end
end
