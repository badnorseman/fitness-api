# Add transaction data e.g. type, id (last 4 for cc or email for paypal)
module Sale
  class CreatePayment
    def initialize(user:, params:)
      @user = user
      @amount = params.fetch(:amount)
      @currency = params.fetch(:currency)
      @payment_method_nonce = params.fetch(:payment_method_nonce)
      @product_id = params.fetch(:product_id)
      @transaction = create_transaction
    end

    def call
      return FailedPayment.new if failure?

      Payment.create(payment_params) do |payment|
        payment.user = @user
      end
    end

    def failure?
      !@transaction.success?
    end

    private

    def payment_params
      { amount: @amount,
        currency: @currency,
        product_id: @product_id,
        transaction_id: @transaction.transaction_id }
    end

    def create_transaction
      Sale::CreateTransaction.new(
        amount: @amount,
        payment_method_nonce: @payment_method_nonce).call
    end
  end
end
