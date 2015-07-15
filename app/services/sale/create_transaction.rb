module Sale
  class CreateTransaction
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
      { amount: @amount,
        payment_method_nonce: @payment_method_nonce }
    end

    def create_sale_transaction
      transaction = Braintree::Transaction.sale(transaction_params)

      if transaction.success?
        OpenStruct.new(
          errors: [],
          success?: true,
          transaction_id: transaction.transaction.id
        )
      else
        OpenStruct.new(
          errors: transaction.errors,
          success?: false,
          transaction_id: nil
        )
      end
    end
  end
end
