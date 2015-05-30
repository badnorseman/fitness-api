module RequestHelper
  def login(user)
    Rails.application.env_config["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
  end

  def json
    @json ||= JSON.parse(response.body)
  end
end
