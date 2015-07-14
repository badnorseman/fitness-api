# Add transaction data e.g. type, id (last 4 for cc or email for paypal)
class CreatePayment
  def initialize(user:, params:)
    @user = user
    @amount = params.fetch(:amount)
    @currency = params.fetch(:currency)
    @payment_method_nonce = params.fetch(:payment_method_nonce)
  end

  def call
    # return FailedPayment.new if unavailable?

    Payment.create(payment_params) do |payment|
      payment.user = @user
    end
  end

  private

  def payment_params
    { amount: @amount,
      currency: @currency }
  end

  # def transaction
  #   Sale::CreateSaleTransaction.new(
  #     amount: @amount,
  #     payment_method_nonce: @payment_method_nonce).call
  # end
end
