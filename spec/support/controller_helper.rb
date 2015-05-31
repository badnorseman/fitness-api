module ControllerHelper
  def login(user)
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
  end
end
