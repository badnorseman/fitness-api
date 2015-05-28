class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user_from_token!

  # Prevents CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session

  protected

  # Allows access to current_user in serializators.
  serialization_scope :current_user

  def authenticate_user_from_token!
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end
end
