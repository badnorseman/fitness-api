class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user,           index: true
      t.integer    :amount,         null: false
      t.string     :currency,       null: false
      t.string     :customer_name
      t.string     :merchant_name
      t.integer    :product_id
      t.string     :product_name
      t.string     :transaction_id
      t.string     :transaction_type
      t.timestamps
    end

    add_index :transactions, :product_id
    add_index :transactions, :transaction_id
    add_index :transactions, :transaction_type
  end
end
