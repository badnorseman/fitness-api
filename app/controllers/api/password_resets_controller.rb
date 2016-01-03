module Api
  class PasswordResetsController < ApplicationController
    skip_before_action :restrict_access
    skip_after_action :verify_authorized

    def new
    end

    def edit
    end

    def create
      user = User.find_by_email(password_reset_parms)
      user.send_password_reset if user
      render json: {}, status: :ok
    end

    private

    def password_reset_parms
      params.fetch(:email)
    end
  end
end
