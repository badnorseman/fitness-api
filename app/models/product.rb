class Product < ActiveRecord::Base
  default_scope { where(ended_at: nil) }

  has_attached_file :image,
    :styles => { :small => "320x160!" }

  belongs_to :user
  has_many :habits, inverse_of: :product, dependent: :destroy

  before_validation :set_uniquable_name

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :uniquable_name, uniqueness: { scope: :user }
  validates :description, presence: true, length: { maximum: 500 }
  validates_attachment :image,
    :content_type => { :content_type => [/image\/jpeg/, /image\/png/] },
    :file_name => { :matches => [/jpeg/, /jpg/, /png/] }

  private

  def set_uniquable_name
    self.uniquable_name = Normalizer.new(text: name).call if name_changed?
  end
end
