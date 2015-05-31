module Api
  class SessionsController < ApplicationController
    skip_before_action :restrict_access

    def create
      user = User.from_omniauth(auth_params)
      session[:user_id] = user.id
      render json: {}, status: :ok
    end

    def destroy
      session[:user_id] = nil
      render json: {}, status: :ok
    end

    def failure
      puts "***** FAILURE *****"
      render json: { errors: user.errors }, status: :unauthorized
    end

    private

    def auth_params
      request.env.fetch("omniauth.auth")
    end
  end
end
