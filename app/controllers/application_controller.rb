class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  before_action :validate_token
  # before_action :restrict_access
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  respond_to :json

  protected

  attr_reader :current_user

  # Allows access to current_user in serializators.
  serialization_scope :current_user

  def validate_token
    begin
      auth0_client_id = Rails.application.secrets.auth0_client_id
      auth0_client_secret = Rails.application.secrets.auth0_client_secret
      authorization = request.headers["Authorization"]
      raise InvalidTokenError if authorization.nil?

      token = request.headers["Authorization"].split(" ").last
      decoded_token = JWT.decode(token,
        JWT.base64url_decode(auth0_client_secret))

      raise InvalidTokenError if auth0_client_id != decoded_token[0]["aud"]

      puts ""
      puts ">>>>>"
      puts decoded_token.inspect
      puts "<<<<<"
      puts ""
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end
end
