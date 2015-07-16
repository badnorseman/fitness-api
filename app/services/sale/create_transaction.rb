module Sale
  class CreateTransaction
    def initialize(amount:, payment_method_nonce:)
      @amount = amount
      @payment_method_nonce = payment_method_nonce
      @transaction = create_braintree_sale_transaction
    end

    def call
      @transaction
    end

    private

    def transaction_params
      { amount: @amount,
        payment_method_nonce: @payment_method_nonce }
    end

    def create_braintree_sale_transaction
      result = Braintree::Transaction.sale(transaction_params)

      if result.success?
        OpenStruct.new(
          errors: [],
          status: result.transaction.status,
          success?: true,
          transaction_id: result.transaction.id
        )
      else
        OpenStruct.new(
          errors: result.message,
          status: nil,
          success?: false,
          transaction_id: nil
        )
      end
    end
  end
end
