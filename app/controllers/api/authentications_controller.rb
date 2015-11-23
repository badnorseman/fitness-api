module Api
  class AuthenticationsController < ApplicationController
    skip_before_action :restrict_access, only: :create
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
  end
end
