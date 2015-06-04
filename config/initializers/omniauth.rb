OmniAuth.config.path_prefix = "/api/auth"

OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_key, Rails.application.secrets.facebook_secret
  provider :identity, fields: [:email]
end
