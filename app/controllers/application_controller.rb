class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  before_action :restrict_access
  before_action :preflight_check
  after_action :set_access_control_headers
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

  def set_access_control_headers
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, OPTIONS, POST"
    response.headers["Access-Control-Allow-Headers"] = "Accept, Authorization, Auth-Token, auth_token, Content-Type, Email, Origin, Token, X-CSRF-Token, X-Requested-With"
    response.headers["Access-Control-Max-Age"] = "1728000"
  end

  def preflight_check
    if request.method == "OPTIONS"
      response.headers["Access-Control-Allow-Origin"] = "http://localhost"
      response.headers["Access-Control-Allow-Methods"] = "GET, OPTIONS, POST"
      response.headers["Access-Control-Allow-Headers"] = "Accept, Authorization, Auth-Token, auth_token, Content-Type, Email, Origin, Token, X-CSRF-Token, X-Requested-With"
      response.headers["Access-Control-Max-Age"] = "1728000"
    end
  end
end
