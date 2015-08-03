class Transactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user,           index: true
      t.integer    :amount,         null: false
      t.string     :currency,       null: false
      t.string     :customer
      t.string     :merchant
      t.string     :product
      t.string     :braintree_transaction_id
      t.string     :braintree_transaction_type
      t.timestamps
    end

    add_index :transactions, :braintree_transaction_id
    add_index :transactions, :braintree_transaction_type
  end
end
