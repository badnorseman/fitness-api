class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  before_action :restrict_access
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  respond_to :json

  puts " -----\n Response\n -----"
  puts response.inspect
  puts " -----\n -----"

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
