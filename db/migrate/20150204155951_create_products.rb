class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user,        index: true
      t.string     :name,        null: false
      t.text       :description, null: false, limit: 500
      t.datetime   :ended_at
      t.timestamps
    end
  end
end
