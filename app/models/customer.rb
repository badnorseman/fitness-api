class Customer < User
  scope :data_for_listing, -> { select(:id, :uid, :name, :email, :gender, :birth_date) }
end
