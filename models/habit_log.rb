class HabitLog < ActiveRecord::Base
  default_scope { where(ended_at: nil) }

  belongs_to :habit_description
  belongs_to :user

  serialize :logged_at, Array

  before_create :maximum_of_habits

  # Validate associations
  validates :habit_description, :user, presence: true

  def logged?
    number_of_logged_at > 0
  end

  private

  def maximum_of_habits
    errors.add(:base, "You can only have ten habits at a time") if number_of_not_ended >= 10
  end

  def number_of_not_ended
    HabitLog.where(user_id: user.id).count
  end

  def number_of_logged_at
    self.logged_at.count
  end
end
