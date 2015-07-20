module Sale
  class CreatePayment
    def initialize(user:, params:)
      @user = user
      @amount = params.fetch(:amount)
      @currency = params.fetch(:currency)
      @merchant_name = merchant_name
      @payment_method_nonce = params.fetch(:payment_method_nonce)
      @product = Product.find(params.fetch(:product_id))
      @transaction = create_transaction
    end

    def call
      return FailedPayment.new(errors: @transaction.errors) if transaction_failure?

      Payment.create(payment_params) do |payment|
        payment.user = @user
      end
    end

    def transaction_failure?
      !@transaction.success?
    end

    private

    def payment_params
      { amount: @amount,
        currency: @currency,
        product_id: @product.id,
        transaction_id: @transaction.transaction_id,
        transaction_type: "SALE" }
    end

    def create_transaction
      Sale::CreateSaleTransaction.new(
        amount: @amount,
        customer: @user,
        merchant_account_id: merchant_account_id,
        merchant_name: @merchant_name,
        payment_method_nonce: @payment_method_nonce,
        product_name: @product.name).call
    end

    def merchant_account_id
      return "fitbird" + @currency if %w(DKK EUR USD).include?(@currency)
    end

    def merchant_name
      "merchant_name"
    end
  end
end
