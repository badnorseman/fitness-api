class DecodedAuthToken < HashWithIndifferentAccess
  def provider
    self[:sub].split("|").first
  end

  def user_id_with_provider
    self[:sub].split("|").last
  end

  def invalid?
    !valid?
  end

  def valid?
    audience_valid? && issuer_valid? && expiration_valid?
  end

  private

  def audience_valid?
    self[:aud] == Rails.application.secrets.auth0_client_id
  end

  def expiration_valid?
    self[:exp] > Time.now.to_i
  end

  def issuer_valid?
    self[:iss] == Rails.application.secrets.auth0_domain
  end
end
