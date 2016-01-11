module Api
  class CustomersController < ApplicationController
    skip_after_action :verify_authorized, only: :index

    # GET /customers.json
    def index
      render json: Customer.data_for_listing, status: :ok
    end
  end
end
