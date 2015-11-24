module Api
  class SessionsController < ApplicationController
    skip_before_action :restrict_access
    skip_before_action :restrict_access_with_token, except: :login
    skip_after_action :verify_authorized

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

    def login
      render json: @current_user, serializer: UserSerializer, status: :ok
    end

    def signup
      @current_user = User.create_with_auth_token(
        decoded_auth_token.provider,
        decoded_auth_token.user_id_with_provider,
        email)
        render json: @current_user, serializer: UserSerializer, status: :ok
    end

    private

    def auth_params
      request.env.fetch("omniauth.auth")
    end

    def decoded_auth_token
      decoded_auth_token ||= AuthToken.decode(token)
    end

    def token
      authorization_header.split(" ").last if authorization_header.present?
    end

    def authorization_header
      request.env.fetch("HTTP_AUTHORIZATION")
    end

    def email
      params.fetch(:email)
    end
  end
end
