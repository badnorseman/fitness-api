module ControllerHelper
  def login(user)
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
  end

  def json
    @json ||= JSON.parse(response.body)
  end
end
