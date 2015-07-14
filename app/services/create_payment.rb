class CreatePayment
  def initialize(user:, params:)
    @user = user
    @amount = params.fetch(:amount)
    @payment_method_nonce = params.fetch(:payment_method_nonce)
    @product_id = params.fetch(:product_id)
  end

  def call
    return FailedBooking.new if unavailable?

    Payment.create(payment_params) do |payment|
      payment.user = @user
    end
  end

  private

  def perform_transaction
    transaction = Braintree::Transaction.sale(
      amount: @amount,
      payment_method_nonce: @payment_method_nonce)

    if transaction.success?
      transaction_id = 1
    else
    end
  end

  def payment_params
    { product_id: @product_id, transaction_id: @transaction_id }
  end
end
