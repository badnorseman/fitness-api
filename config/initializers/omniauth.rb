OmniAuth.config.path_prefix = "/api/auth"

OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.secrets.facebook_key,
    Rails.application.secrets.facebook_secret, {
      scope: "email,public_profile",
      info_fields: "email,name",
      provider_ignores_state: true,
      client_options: { :ssl => { :ca_file => "/usr/lib/ssl/certs/ca-certificates.crt" }}
    }
  provider :identity,
    fields: [:email],
    on_failed_registration: lambda { |env|
      Api::IdentitiesController.action(:new).call(env)
    }
end
