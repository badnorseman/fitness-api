module Api
  class SessionsController < ApplicationController
    skip_before_action :restrict_access
    skip_after_action :verify_authorized

    def create_from_token
      # token = token_params.split(" ").last
      # decoded_token ||= Token.decode(token)
      # user = User.from_token(decoded_token.provider, decoded_token.user_id_from_provider)
      user = @current_user
      session[:user_id] = user.id
      render json: user, serializer: SessionSerializer, status: :ok
    end

    def create
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
