class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  before_action :set_origin
  before_action :set_headers
  before_action :display_request
  after_action :display_response
  before_action :restrict_access
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

  def display_request
    puts " -----\n Request\n -----"
    puts request.headers.inspect
    puts " -----\n -----"
  end

  def display_response
    puts " -----\n Response\n -----"
    puts response.headers.inspect
    puts " -----\n -----"
  end

  def set_origin
    @origin = request.headers["HTTP_ORIGIN"]
  end

  def set_headers
    if @origin
      allowed = ["*", "localhost"]
      allowed.each do |host|
        if @origin.match /^https?:\/\/#{Regexp.escape(host)}/i
          headers["Access-Control-Allow-Origin"] = @origin
          break
        end
      end
      headers["Access-Control-Allow-Methods"] = "GET, OPTIONS"
      headers["Access-Control-Request-Method"] = "*"
      headers["Access-Control-Allow-Headers"] = "Content-Type"
    end
  end
end
