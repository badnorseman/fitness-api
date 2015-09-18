module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update]
    skip_after_action :verify_authorized, only: :index

    # GET /users.json
    def index
      render json: policy_scope(User).data_for_listing, status: :ok
    end

    # GET /users/1.json
    def show
      render json: @user, status: :ok
    end

    # PUT /users/1.json
    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    private

    def user_params
      params.require(:user).
        permit(:password,
               :password_confirmation,
               :email,
               :name,
               :gender,
               :birth_date,
               :height,
               :weight,
               :avatar)
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
