module Sale
  class CreateSaleTransaction
    def initialize(amount:, payment_method_nonce:)
      @amount = amount
      @payment_method_nonce = payment_method_nonce
    end

    def call
      @transaction_status = generate_sale_transaction
    end

    private

    def generate_sale_transaction
      transaction = Braintree::Transaction.sale(
        amount: @amount,
        payment_method_nonce: @payment_method_nonce)

      if transaction.success?
        @transaction_status = "SUCCESS"
      else
        @transaction_status = "ERROR"
      end
    end
  end
end
