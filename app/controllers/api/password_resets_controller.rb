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
      user = User.find_by_email(password_reset_parms)
      user.create_password_reset_token if user
      user.send_password_reset_email if user
      render json: { message: "PASSWORD RESET INSTRUCTIONS SENT."}, status: :ok
    end

    # PUT /password_resets/token.json
    def update
    end

    private

    def password_reset_parms
      params.fetch(:email)
    end
  end
end
