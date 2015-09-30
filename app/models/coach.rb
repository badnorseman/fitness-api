class Coach < User
  default_scope { where(coach: true) }
  scope :data_for_listing, -> { select(:id, :email, :administrator, :coach, :name, :gender, :birth_date) }
end
