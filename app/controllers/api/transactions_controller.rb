module Api
  class TransactionsController < ApplicationController
    skip_after_action :verify_authorized

    # POST /transactions.json
    def create
      @transaction = Braintree::Transaction.sale(
        amount: amount,
        payment_method_nonce: payment_method_nonce)

      if @transaction.success?
        render json: @transaction, status: :created
      else
        render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    private

    def amount
      params.fetch(:amount)
    end

    def payment_method_nonce
      params.fetch(:payment_method_nonce)
    end
  end
end
