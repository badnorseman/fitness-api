module Sale
  class CreateSaleTransaction
    def initialize(amount:, payment_method_nonce:)
      @amount = amount
      @payment_method_nonce = payment_method_nonce
      @transaction = create_sale_transaction
    end

    def call
      @transaction
    end

    private

    def transaction_params
      { amount: @amount, payment_method_nonce: @payment_method_nonce }
    end

    def create_sale_transaction
      result = Braintree::Transaction.sale(transaction_params)

      if result.success?
        { transaction:
          { transaction_id: result.transaction.id }
        }
      else
        { transaction:
          { errors: result.errors }
        }
      end
    end
  end
end
