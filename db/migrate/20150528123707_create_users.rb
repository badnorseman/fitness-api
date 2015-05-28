class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :uid
      t.string     :provider
      t.string     :token,        null: false
      t.string     :first_name
      t.string     :last_name
      t.string     :gender,       limit: 1
      t.date       :birth_date
      t.integer    :height
      t.integer    :weight
      t.text       :roles,        array: true, default: []
      t.timestamps null: false
    end

    add_index :users, :token, unique: true
  end
end
