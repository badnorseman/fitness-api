class Tag < ActiveRecord::Base
  default_scope { where(ended_at: nil) }

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :habit_descriptions, through: :taggings, source: :taggable, source_type: HabitDescription
  has_many :exercise_descriptions, through: :taggings, source: :taggable, source_type: ExerciseDescription

  before_validation :set_uniquable_name

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :uniquable_name, uniqueness: true

  def in_use?
    taggings_in_use > 0
  end

  private

  def set_uniquable_name
    self.uniquable_name = Normalizer.new(text: name).call if name_changed?
  end

  def taggings_in_use
    Tagging.where(tag_id: id).count
  end
end
