class ApplicationController < ActionController::Base
  include Pundit

  # Prevents CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session

  before_action :authenticate_user_from_token!
  
  def authenticate_user_from_token!
  end

  protected

  # Allows access to current_user in serializators.
  serialization_scope :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
