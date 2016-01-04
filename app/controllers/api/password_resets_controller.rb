module Api
  class PasswordResetsController < ApplicationController
    skip_before_action :restrict_access
    skip_after_action :verify_authorized

    def edit
      puts "UPDATE"
    end

    # POST /password_resets.json
    def create
      @user = User.find_by_email(email)
      if @user
        user.create_password_reset_token
        user.send_password_reset_email
      end
      render json: {}, status: :ok
    end

    # PUT /password_resets/token.json
    def update
      if @user.password_reset_valid && @user.update(user_params)
        render json: {}, status: :ok
      else
        render json: { errors: "Unable to reset password." }, status: :unprocessable_entity, location: nil
      end
    end

    private

    def password_reset_parms
      params.require(:password_reset).
        permit(:email)
    end

    def email
      password_reset_parms.fetch(:email)
      # params.fetch(:email)
    end

    def password_reset_token
      params.fetch(:id)
      # password_reset_parms.fetch(:id)
    end
  end
end
