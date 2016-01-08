module Sale
  class CreateTransaction
    def initialize(user:, params:)
      @user = user
      @amount = params.fetch(:amount)
      @currency = params.fetch(:currency)
      @payment_method_nonce = params.fetch(:payment_method_nonce)
      @product = Product.find(params.fetch(:product_id))
      @sale_transaction = create_sale_transaction
    end

    def call
      return FailedTransaction.new(errors: @sale_transaction.errors) if sale_transaction_failure?

      Transaction.create(transaction_params) do |transaction|
        transaction.user = @user
      end
    end

    def sale_transaction_failure?
      !@sale_transaction.success?
    end

    private

    def transaction_params
      { amount: @amount,
        currency: @currency,
        product_id: @product.id,
        transaction_id: @sale_transaction.transaction_id,
        transaction_type: "SALE" }
    end

    def create_sale_transaction
      Sale::CreateSaleTransaction.new(
        amount: @amount,
        customer_name: @user.name,
        merchant_account_id: merchant_account_id,
        merchant_name: @product.user.name,
        payment_method_nonce: @payment_method_nonce,
        product_name: @product.name).call
    end

    def merchant_account_id
      return "fitbird" + @currency if %w(DKK EUR USD).include?(@currency)
    end
  end
end
