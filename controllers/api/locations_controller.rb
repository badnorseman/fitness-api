module Api
  class LocationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :create, :update]
    after_action :verify_authorized

    # GET /users/1/location.json
    def show
      @location = @user.location

      render json: @location, status: :ok
    end

    # POST /users/1/location.json
    def create
      @location = @user.build_location(location_params)
      authorize @location

      if @location.save
        render json: @location, status: :created
      else
        render json: { errors: @location.errors }, status: :unprocessable_entity
      end
    end

    # PUT /users/1/location.json
    def update
      @location = @user.location
      authorize @location

      if @location.update(location_params)
        render json: @location, status: :ok
      else
        render json: { errors: @location.errors }, status: :unprocessable_entity
      end
    end

    private

    def location_params
      params.require(:location).
        permit(:company,
               :address_line1,
               :address_line2,
               :postal_code,
               :city,
               :state_province,
               :country,
               :phone_number)
    end

    def set_user
      @user = User.find(user_id)
      authorize @user
    end

    def user_id
      params.fetch(:id)
    end
  end
end
