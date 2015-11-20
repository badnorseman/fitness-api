module Api
  class Auth0Controller < ApplicationController
    skip_after_action :verify_authorized

    def create
      puts auth_params
      # user = User.from_auth(auth_params)
      # session[:user_id] = user.id
      # render json: user, serializer: SessionSerializer, status: :ok
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
      params.fetch("auth")
      # request.env.fetch("auth")
    end
  end
end
