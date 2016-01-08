module Sale
  class CreateSaleTransaction
    def initialize(amount:, customer_name:, merchant_account_id:, merchant_name:, payment_method_nonce:, product_name:)
      @amount = amount
      @customer_name = customer_name
      @merchant_account_id = merchant_account_id
      @merchant_name = merchant_name
      @payment_method_nonce = payment_method_nonce
      @product_name = product_name
      @transaction = create_braintree_sale_transaction
    end

    def call
      @transaction
    end

    private

    def transaction_params
      { amount: @amount,
        merchant_account_id: @merchant_account_id,
        payment_method_nonce: @payment_method_nonce,
        custom_fields:
        { customer_name: @customer_name,
          merchant_name: @merchant_name,
          product_name: @product_name }}
    end

    def create_braintree_sale_transaction
      result = Braintree::Transaction.sale(transaction_params)

      if result.success?
        OpenStruct.new(
          errors: [],
          status: result.transaction.status,
          success?: true,
          transaction_id: result.transaction.id)
      else
        OpenStruct.new(
          errors: result.message,
          status: nil,
          success?: false,
          transaction_id: nil)
      end
    end
  end
end
