module Api
  class IdentitiesController < ApplicationController
    skip_before_action :restrict_access, only: [:new, :create]
    skip_after_action :verify_authorized, only: [:new, :create]

    # POST /auth/identity/register.json
    def new
      identity = request.env.fetch("omniauth.identity") || Identity.new
      render json: identity, location: nil
    end

    # POST /identities/update.json
    def create
      identity = Identity.find_by_email(email)

      if identity
        UserMailer.new_password(identity).deliver_now
      end
      render json: {}, status: :ok
    end

    # PUT /identities/update.json
    def update
      identity = Identity.find_by_id(@current_user.uid)
      authorize identity

      if identity.update(password: password, password_confirmation: password_confirmation)
        render json: identity, status: :ok
      else
        render json: { errors: identity.errors.full_messages }, status: :unprocessable_entity, location: nil
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

    def password
      identity_params.fetch(:password)
    end

    def password_confirmation
      identity_params.fetch(:password_confirmation)
    end
  end
end
