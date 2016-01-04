module Api
  class PasswordResetsController < ApplicationController
    skip_before_action :restrict_access
    skip_after_action :verify_authorized

    def edit
      puts "UPDATE"
      @user = User.find_by_password_reset_token(password_reset_token)
    end

    # POST /password_resets.json
    def create
      user = User.find_by_email(email)
      user.create_password_reset_token if user
      user.send_password_reset_email if user
      render json: { message: "Sent reset password instructions." }, status: :ok
    end

    # PUT /password_resets/token.json
    def update
      puts "UPDATE"
    end

    private

    def password_reset_parms
      params.require(:password_reset).
        permit(:email)
    end

    def email
      password_reset_parms.fetch(:email)
    end

    def password_reset_token
      params.fetch(:id)
      # password_reset_parms.fetch(:id)
    end
  end
end
