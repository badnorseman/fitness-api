# Remove Transaction#update. Update is done by #delete and another #create.
# Change Transaction#delete to be a void transaction.
# Add type to Transaction e.g. sale, void
# What attribute(s) should be editable on Transaction?
module Api
  class TransactionsController < ApplicationController
    before_action :set_transaction, only: [:show, :update, :destroy]
    skip_after_action :verify_authorized, only: :new

    # GET /transactions.json
    def index
      render json: policy_scope(Transaction).order(created_at: :desc), status: :ok
    end

    # GET /transactions/1.json
    def show
      render json: @transaction, status: :ok
    end

    # GET /transactions/new.json
    def new
      @client_token = Sale::GenerateClientToken.new.client_token
      render json: { client_token: @client_token }, status: :ok
    end

    # POST /transactions.json
    def create
      @transaction = Sale::CreateTransaction.new(user: current_user, params: transaction_params).call
      authorize @transaction

      if @transaction.persisted?
        render json: @transaction, status: :created
      else
        render json: { errors: @transaction.errors }, status: :unprocessable_entity
      end
    end

    # PUT /transactions/1.json
    def update
      if @transaction.update(transaction_params)
        render json: @transaction, status: :ok
      else
        render json: { errors: @transaction.errors }, status: :unprocessable_entity, location: nil
      end
    end

    # DELETE /transactions/1.json
    def destroy
      @transaction.destroy
      head :no_content
    end

    private

    def transaction_params
      params.require(:transaction).
        permit(:amount,
               :currency,
               :payment_method_nonce,
               :product_id)
    end

    def set_transaction
      @transaction = Transaction.find(transaction_id)
      authorize @transaction
    end

    def transaction_id
      params.fetch(:id)
    end
  end
end
