class Identity < OmniAuth::Identity::Models::ActiveRecord
  # Validate attributes
  validates :email, presence: true, uniqueness: true
end
