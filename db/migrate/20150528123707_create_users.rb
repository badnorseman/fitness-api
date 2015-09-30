class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :uid
      t.string     :provider
      t.string     :token,        null: false
      t.string     :email
      t.boolean    :administrator
      t.boolean    :coach,        index: true
      t.string     :name
      t.string     :gender,       limit: 1
      t.date       :birth_date
      t.timestamps
    end

    add_index :users, :uid, unique: true
    add_index :users, :token, unique: true
  end
end
