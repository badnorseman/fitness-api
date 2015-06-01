module Api
  class UsersController < ApplicationController
    skip_before_action :restrict_access
    before_action :set_user, only: :show
    skip_after_action :verify_authorized, only: :index

    # GET /users.json
    def index
      render json: User.find_each, status: :ok
      # render json: policy_scope(User).data_for_listing, status: :ok
    end

    # GET /users/1.json
    def show
      render json: @user, status: :ok
    end

    private

    def user_params
      params.require(:user).
        permit(:password,
               :password_confirmation,
               :first_name,
               :last_name,
               :gender,
               :birth_date,
               :height,
               :weight)
    end

    def set_user
      @user = User.find(user_id)
      authorize @user
    end

    def user_id
      params.fetch(:id)
    end
  end
end
