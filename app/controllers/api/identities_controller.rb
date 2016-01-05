module Api
  class IdentitiesController < ApplicationController
    skip_before_action :restrict_access, only: :new
    skip_after_action :verify_authorized, only: :new

    # POST /auth/identity/register.json
    def new
      identity = request.env.fetch("omniauth.identity") || Identity.new
      render json: identity, location: nil
    end

    def create
      identity = Identity.find_by_email(identity_params.fetch(:email))

      if identity
        UserMailer.new_password(identity).deliver_now
      end
      render json: {}, status: :ok
    end

    # PUT /auth/identity/update.json
    # Update password
    def update
      identity = Identity.find_by_id(@current_user.uid)
      authorize identity

      if identity.update(identity_params)
        render json: identity, status: :ok
      else
        render json: { errors: identity.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    private

    def identity_params
      params.require(:identity).
        permit(:password,
               :password_confirmation)
    end
  end
end
