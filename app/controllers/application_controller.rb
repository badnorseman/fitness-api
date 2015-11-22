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

  def restrict_access
    begin
      authorization = request.headers["Authorization"]
      raise InvalidTokenError if authorization.nil?
      token = authorization.split(" ").last
      decoded_auth_token ||= AuthToken.decode(token)
      raise InvalidTokenError if decoded_auth_token.invalid?
      @current_user = User.find_by(
        provider: decoded_auth_token.provider,
        uid: decoded_auth_token.user_id_at_provider)
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
  end
end
