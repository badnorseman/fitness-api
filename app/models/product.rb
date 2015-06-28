class Product < ActiveRecord::Base
  default_scope { where(ended_at: nil) }

  has_attached_file :image,
    :styles => { :small => "100x100>" },
    :url => "/images/products/:id/:style/:basename.:extension",
    :path => "/:rails_root/images/products/:id/:style/:basename.:extension"

  belongs_to :user
  has_many :habits, inverse_of: :product, dependent: :destroy

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_attachment_size :image, :less_than => 5.megabytes
end
