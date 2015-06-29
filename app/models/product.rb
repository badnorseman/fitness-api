class Product < ActiveRecord::Base
  default_scope { where(ended_at: nil) }

  has_attached_file :image,
    :styles => { :small => "100x100>" }

  belongs_to :user
  has_many :habits, inverse_of: :product, dependent: :destroy

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  # validates :image, presence: true
  validates_with AttachmentContentTypeValidator, :attributes => :image, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentFileNameValidator, :attributes => :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 5.megabytes
end
