# Move code to Payment#Create once it is working and
# delete this controller and it's route.
module Api
  class TransactionsController < ApplicationController
    skip_after_action :verify_authorized

    # POST /transactions.json
    def create
      transaction = Braintree::Transaction.sale(
        amount: params[:transaction][:amount],
        payment_method_nonce: params[:transaction][:payment_method_nonce])

      puts transaction.inspect

      if transaction.success?
        render json: {}, status: :created
      else
        render json: {}, status: :unprocessable_entity, location: nil
      end
    end

    private

    def transaction_params
      params.require(:transaction).
        permit(:amount,
               :payment_method_nonce)
    end
  end
end
