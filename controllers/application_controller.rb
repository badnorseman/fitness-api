class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  # Prevents CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session

  protected

  # Allows access to current_user in serializators.
  serialization_scope :current_user
end
