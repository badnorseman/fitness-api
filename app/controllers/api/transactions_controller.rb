# Move code to Payment#Create once it is working and
# delete this controller and it's route.
module Api
  class TransactionsController < ApplicationController
    skip_after_action :verify_authorized

    # POST /transactions.json
    def create
      result = Braintree::Transaction.new(
        amount: params[:transaction][:amount],
        payment_method_nonce: params[:transaction][:payment_method_nonce]).call

      if result.success?
        render json: {transaction_id: result.transaction.id}, status: :created
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
