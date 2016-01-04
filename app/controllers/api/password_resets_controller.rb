module Api
  class PasswordResetsController < ApplicationController
    skip_before_action :restrict_access
    skip_after_action :verify_authorized

    def new
    end

    def edit
    end

    # POST /password_resets.json
    def create
      user_password_reset_parms = password_reset_parms
      user = User.find_by_email(email)
      user.create_password_reset_token if user
      user.send_password_reset_email if user
      render json: { message: "Sent instructions to reset password." }, status: :ok
    end

    # PUT /password_resets/token.json
    def update
    end

    private

    def password_reset_parms
      params.require(:password_reset).
        permit(:email)
    end

    def email
      password_reset_parms.fetch(:email)
    end
  end
end
