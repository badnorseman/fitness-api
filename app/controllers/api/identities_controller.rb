module Api
  class IdentitiesController < ApplicationController
    skip_before_action :restrict_access, only: [:new, :create]
    skip_after_action :verify_authorized, only: [:new, :create]

    # POST /auth/identity/register.json
    def new
      @identity = request.env.fetch("omniauth.identity") || Identity.new
      render json: @identity, location: nil
    end

    # POST /identities/update.json
    def create
      @identity = Identity.find_by_email(identity_params.fetch(:email))
      auto_password = SecureRandom.hex

      if @identity.update(
        password: auto_password,
        password_confirmation: auto_password
      )
        UserMailer.new_password(@identity, auto_password).deliver_now
        render json: @identity, status: :ok
      else
        render json: { errors: @identity.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    # PUT /identities/update.json
    def update
      @identity = Identity.find_by_id(identity_params.fetch(:id))
      authorize @identity

      if @identity.update(identity_params)
        render json: @identity, status: :ok
      else
        render json: { errors: @identity.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    private

    def identity_params
      params.require(:identity).
        permit(:id,
               :email,
               :password,
               :password_confirmation)
    end
  end
end
