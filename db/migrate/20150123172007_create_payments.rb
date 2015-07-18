class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user,           index: true
      t.integer    :amount,         null: false
      t.string     :currency,       null: false
      t.integer    :customer_id
      t.integer    :product_id
      t.string     :transaction_id
      t.string     :transaction_type
      t.timestamps
    end

    add_index :payments, :product_id
    add_index :payments, :transaction_id
  end
end
