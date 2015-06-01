OmniAuth.config.path_prefix = "/api/auth"

OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "262325467304404", "9b99168917274f014915e1cbb9704e3b"
  provider :identity, fields: [:email]
end
