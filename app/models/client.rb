class Client < User
  default_scope { where(coach: true) }
  scope :data_for_listing, -> { select(:id, :uid, :name, :email, :gender, :birth_date) }
end
