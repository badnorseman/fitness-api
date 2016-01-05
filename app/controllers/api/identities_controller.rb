module Api
  class IdentitiesController < ApplicationController
    skip_before_action :restrict_access
    skip_after_action :verify_authorized

    # Sign up
    def new
      @identity = request.env.fetch("omniauth.identity") || Identity.new
      render json: @identity, location: nil
    end

    # Create password
    def create
      @identity = Identity.find_by_email(email)
      if @identity
        UserMailer.new_password(@identity).deliver_now
      end
      render json: {}, status: :ok
    end

    # Update password
    def update
      @identity = Identity.find_by(@current_user.uid)
      if @identity.update(identity_params)
        render json: @identity, status: :ok
      else
        render json: { errors: @identity.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    private

    def identity_parms
      params.require(:identity).
        permit(:email,
               :password,
               :password_confirmation)
    end

    def email
      identity_parms.fetch(:email)
    end
  end
end
