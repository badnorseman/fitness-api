OmniAuth.config.path_prefix = "/api/auth"

OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.secrets.facebook_key,
    Rails.application.secrets.facebook_secret, {
      :scope => "email,public_profile,user_birthday",
      provider_ignores_state: true
    }
  provider :google_oauth2,
    Rails.application.secrets.google_key,
    Rails.application.secrets.google_secret, {
      :scope => "email,profile"
    }
  provider :identity,
    fields: [:email],
    on_failed_registration: lambda { |env|
      Api::IdentitiesController.action(:new).call(env)
    }
end
