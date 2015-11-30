class AuthToken
  def self.decode(token)
    DecodedAuthToken.new(
      JWT.decode(
        token,
        JWT.base64url_decode(
          Rails.application.secrets.auth0_client_secret)
      )[0])
  rescue
    nil
  end
end
