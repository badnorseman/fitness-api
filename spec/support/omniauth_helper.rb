module OmniAuthHelper
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:identity] = OmniAuth::AuthHash.new({
    :provider => "identity",
    :uid => "1",
    "info" => {
    "first_name" => "mock_first_name",
    "last_name" => "mock_last_name"
    },
    "credentials" => {
    "token" => "mock_token",
    "secret" => "mock_secret"
    }
  })
end
