module ControllerHelper
  def sign_in(user = double("user"))
    if user.nil?
      allow(request.env["warden"]).to receive(:authenticate!).
                                      and_throw(:warden, :scope => :user)
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  def login(user)
    # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:identity]
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
  end

  def json
    @json ||= JSON.parse(response.body)
  end
end
