class ApplicationController < ActionController::Base
  include Pundit
  before_action :restrict_access
  after_action :verify_authorized, :except => :index

  respond_to :json

  # Prevents CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session

  protected

  attr_reader :current_user

  # Allows access to current_user in serializators.
  serialization_scope :current_user

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end
end
