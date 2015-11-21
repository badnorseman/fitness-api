module Api
  class SessionsController < ApplicationController
    # skip_before_action :restrict_access_with_omniauth
    skip_after_action :verify_authorized

    def create
      user = @current_user
      session[:user_id] = user.id
      render json: user, serializer: SessionSerializer, status: :ok
    end

    def create_from_omniauth
      user = User.from_omniauth(auth_params)
      session[:user_id] = user.id
      render json: user, serializer: SessionSerializer, status: :ok
    end

    def destroy
      session[:user_id] = nil
      render json: {}, status: :ok
    end

    def failure
      render json: { errors: params[:message] }, status: :unauthorized
    end

    private

    def auth_params
      request.env.fetch("omniauth.auth")
    end

    def token_params
      request.env.fetch("HTTP_AUTHORIZATION")
    end
  end
end
