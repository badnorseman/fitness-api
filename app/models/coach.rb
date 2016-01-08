class Coach < User
  default_scope { where(coach: true) }
  scope :data_for_listing, -> { select(:id, :uid, :email, :name, :gender) }
end
