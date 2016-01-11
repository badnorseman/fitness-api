module Api
  class ClientsController < ApplicationController
    skip_after_action :verify_authorized, only: :index

    # GET /clients.json
    def index
      render json: Client.data_for_listing, status: :ok
    end
  end
end
