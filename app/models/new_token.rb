class NewToken < HashWithIndifferentAccess
  def initialize(token)
    @token = decode(token)
    puts @token
  end

  def decode(token)
    JWT.decode(token,
      JWT.base64url_decode(
        Rails.application.secrets.auth0_client_secret)
    )[0]
  end

  def is_valid?
    audience_valid? && issuer_valid? && expiration_valid?
  end

  def audience_valid?
    @token["aud"] == Rails.application.secrets.auth0_client_id
  end

  def issuer_valid?
    self[:iss] == Rails.application.secrets.auth0_domain
  end

  def expiration_valid?
    self[:exp] > Time.now.to_i
  end

  def provider
    self[:sub].split("|").first
  end

  def user_id_from_provider
    self[:sub].split("|").last
  end
end
