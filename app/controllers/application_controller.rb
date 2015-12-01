class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  before_action :restrict_access
  after_action :access_control_headers
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  respond_to :json

  protected

  attr_reader :current_user

  # Allows access to current_user in serializators.
  serialization_scope :current_user

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end

  private

  def access_control_headers
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, DELETE, OPTIONS, PATCH, POST, PUT"
    response.headers["Access-Control-Allow-Headers"] = "Accept, Authorization, Auth-Token, Content-Type, Email, Origin, Token"
    response.headers["Access-Control-Max-Age"] = "1728000"
  end
end
