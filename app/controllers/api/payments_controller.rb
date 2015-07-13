# Will Payment#update and Payment#delete be used?
# Move Payment#create into service object
# Add Product (product_id)
# Remove PaymentPlan (payment_plan_id)
# Add transaction data e.g. type, id (last 4 for cc or email for paypal)
module Api
  class PaymentsController < ApplicationController
    skip_after_action :verify_authorized, only: :new
    before_action :set_payment, only: [:show, :update, :destroy]

    # GET /payments.json
    def index
      render json: policy_scope(Payment).order(:transaction_id), status: :ok
    end

    # GET /payments/1.json
    def show
      render json: @payment, status: :ok
    end

    # GET /payments/new.json
    def new
      @client_token = generate_client_token
      render json: { client_token: @client_token }, status: :ok
    end

    # POST /payments.json
    def create
      @transaction = Braintree::Transaction.sale(
        amount: amount,
        payment_method_nonce: payment_method_nonce)

      if @transaction.success?
        # Add transaction data to payment_params
        @payment = Payment.new(payment_params)
        @payment.user = current_user
        authorize @payment

        if @payment.save
          render json: @payment, status: :created
        else
          render json: { errors: @payment.errors }, status: :unprocessable_entity
        end
      else
        render json: {}, status: :unprocessable_entity, location: nil
      end
    end

    # PUT /payments/1.json
    def update
      if @payment.update(payment_params)
        render json: @payment, status: :ok
      else
        render json: { errors: @payment.errors }, status: :unprocessable_entity, location: nil
      end
    end

    # DELETE /payments/1.json
    def destroy
      @payment.destroy
      head :no_content
    end

    private

    def payment_params
      params.require(:payment).
        permit(:transaction_id,
               :customer_id,
               :payment_plan_id)
    end

    def generate_client_token
      Braintree::ClientToken.generate
    end

    def set_payment
      @payment = Payment.find(payment_id)
      authorize @payment
    end

    def payment_id
      params.fetch(:id)
    end

    def amount
      params[:transaction][:amount]
    end

    def payment_method_nonce
      params[:transaction][:payment_method_nonce]
    end
  end
end
