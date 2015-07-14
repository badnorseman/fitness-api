# Add transaction data e.g. type, id (last 4 for cc or email for paypal)
module Sale
  class CreatePayment
    def initialize(user:, params:)
      @user = user
      @amount = params.fetch(:amount)
      @payment_method_nonce = params.fetch(:payment_method_nonce)
      @product_id = params.fetch(:product_id)
    end

    def call
      # return FailedBooking.new if unavailable?

      Payment.create(payment_params) do |payment|
        payment.user = @user
      end
    end

    private

    def payment_params
      { product_id: @product_id,
        transaction_id: transaction_id }
    end

    def transaction_id
      Sale::CreateSaleTransaction.new(
        amount: @amount,
        payment_method_nonce: @payment_method_nonce).call
    end
  end
end
