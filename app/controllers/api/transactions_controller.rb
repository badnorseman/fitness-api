# Move code to Payment#Create once it is working and
# delete this controller and it's route.
module Api
  class TransactionsController < ApplicationController
    skip_after_action :verify_authorized

    # POST /transactions.json
    def create
      @transaction = Braintree::Transaction.sale(
        amount: amount,
        payment_method_nonce: payment_method_nonce)

      if @transaction.success?
        render json: {}, status: :created
      else
        render json: {}, status: :unprocessable_entity, location: nil
        # render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    private

    def amount
      params[:transaction][:amount]
    end

    def payment_method_nonce
      params[:transaction][:payment_method_nonce]
    end

    def transaction_params
      params.require(:transaction).
        permit(:amount,
               :payment_method_nonce)
    end
  end
end
