class Product < ActiveRecord::Base
  default_scope { where(ended_at: nil) }

  has_attached_file :image,
    :default_url => "http://:s3_bucket.s3.amazonaws.com/:rails_env/:attachment/:class/defaults/:style.png",
    :styles => { :small => "100x100>" }

  belongs_to :user
  has_many :habits, inverse_of: :product, dependent: :destroy

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates_attachment :image,
    :content_type => { :content_type => [/image\/jpeg/, /image\/png/] },
    :file_name => { :matches => [/jpeg/, /jpg/, /png/] }
end
