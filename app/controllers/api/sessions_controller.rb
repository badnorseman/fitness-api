module Api
  class SessionsController < ApplicationController
    skip_before_action :omniauth_restrict_access
    skip_before_action :restrict_access, except: :show
    skip_after_action :verify_authorized

    def show
      render json: @current_user, serializer: UserSerializer, status: :ok
    end

    def create
      @current_user = User.create_with_auth_token(
        decoded_auth_token.provider,
        decoded_auth_token.user_id_with_provider,
        email)
        render json: @current_user, serializer: UserSerializer, status: :ok
    end

    def omniauth_create
      user = User.from_omniauth(omniauth_params)
      session[:user_id] = user.id
      render json: user, serializer: SessionSerializer, status: :ok
    end

    def omniauth_destroy
      session[:user_id] = nil
      render json: {}, status: :ok
    end

    def omniauth_failure
      render json: { errors: params[:message] }, status: :unauthorized
    end

    private

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

    def omniauth_params
      request.env.fetch("omniauth.auth")
    end
  end
end
