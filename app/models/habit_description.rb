class HabitDescription < ActiveRecord::Base
  default_scope { where(ended_at: nil) }

  belongs_to :user
  has_many :habits, dependent: :destroy
  has_many :habit_logs, dependent: :destroy
  has_many :users, through: :habit_logs
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  before_validation :set_uniquable_name

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :uniquable_name, uniqueness: { scope: :user }
  validates :summary, presence: true, length: { maximum: 100 }
  validates :description, presence: true

  def in_use?
    habits_in_use + habit_logs_in_use > 0
  end

  def tag_list
    tags.all.collect(&:name).sort.join(", ")
  end

  def tag_list=(value)
  end

  def self.search_by_tags(tag_list:)
    SearchTaggableByTags.new(tag_list: tag_list).call
  end

  private

  def habits_in_use
    Habit.where(habit_description_id: id).count
  end

  def habit_logs_in_use
    HabitLog.where(habit_description_id: id).count
  end

  def set_uniquable_name
    self.uniquable_name = Normalizer.new(text: name).call if name_changed?
  end
end
