module Api
  class CustomersController < ApplicationController
    # GET /customers.json
    def index
      render json: policy_scope(Customer).data_for_listing, status: :ok
    end
  end
end
