module Api
  class IdentitiesController < ApplicationController
    skip_before_action :restrict_access, only: [:new, :create]
    skip_after_action :verify_authorized, only: [:new, :create]

    # POST /auth/identity/register.json
    # Sign up with email authentication
    def new
      @identity = request.env.fetch("omniauth.identity") || Identity.new
      render json: @identity, location: nil
    end

    # POST /identities/create.json
    # Send email with new password
    def create
      @identity = Identity.find_by_email(email)
      generated_password = SecureRandom.hex

      if @identity && @identity.update(
        password: generated_password,
        password_confirmation: generated_password
      )
        UserMailer.new_password(@identity, generated_password).deliver_now
      end

      head :no_content
    end

    # PUT /identities/update.json
    # Update email authentication
    def update
      @identity = Identity.find(identity_id)
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
        permit(:email,
               :password,
               :password_confirmation)
    end

    def email
      identity_params.fetch(:email)
    end

    def identity_id
      params.fetch(:id)
    end
  end
end
