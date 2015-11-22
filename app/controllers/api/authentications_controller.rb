module Api
  class AuthenticationsController < ApplicationController
    skip_after_action :verify_authorized

    # We need to be able to handle user that is authenticated,
    # but not yet created in api.
    # Possible solution is to precreate users through Auth0.
    def create
      if @current_user
        render json: user, serializer: UserSerializer, status: :ok
      else
        render json: {}, status: :unauthorized
      end
    end

    # User is created if not found. See user model
    def create_from_omniauth
      user = User.from_omniauth(auth_params)
      session[:user_id] = user.id
      render json: user, serializer: UserSerializer, status: :ok
    end

    def failure
    end

    private

    def auth_params
      request.env.fetch("HTTP_AUTHORIZATION")
    end
  end
end
