class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :user,           index: true
      t.string     :company,        limit: 100
      t.string     :address_line1,  limit: 100
      t.string     :address_line2,  limit: 100
      t.string     :postal_code,    limit: 20
      t.string     :city,           limit: 100
      t.string     :state_province, limit: 100
      t.string     :country,        limit: 100
      t.string     :phone_number,   limit: 20
      t.timestamps null: false
    end
  end
end
