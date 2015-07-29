class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user,           index: true
      t.string     :name,           null: false, limit: 50
      t.string     :uniquable_name, null: false, limit: 50
      t.text       :description,    null: false, limit: 500
      t.string     :currency
      t.integer    :price
      t.datetime   :ended_at
      t.timestamps
    end

    add_index :products, [:user_id, :uniquable_name], unique: true
  end
end
