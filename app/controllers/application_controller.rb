class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  before_action :restrict_access
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  respond_to :json

  protected

  attr_reader :current_user

  # Allows access to current_user in serializators.
  serialization_scope :current_user

  # def restrict_access
  #   authenticate_or_request_with_http_token do |token, options|
  #     @current_user = User.find_by(token: token)
  #   end
  # end

  def restrict_access
    begin
      raise InvalidTokenError if authorization_header.nil?
      raise InvalidTokenError if decoded_auth_token.invalid?
      @current_user = User.find_by(
        provider: decoded_auth_token.provider,
        uid: decoded_auth_token.user_id_with_provider)
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
  end

  private

  def decoded_auth_token
    decoded_auth_token ||= AuthToken.decode(token)
  end

  def token
    authorization_header.split(" ").last
  end

  def authorization_header
    request.env.fetch("HTTP_AUTHORIZATION")
  end
end
