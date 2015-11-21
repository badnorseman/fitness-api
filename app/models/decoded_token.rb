class DecodedToken < HashWithIndifferentAccess
  def client_id_valid?
    self[:aud] = Rails.application.secrets.auth0_client_id
  end

  def issuer_valid?
    self[:iss] = Rails.application.secrets.auth0_domain
  end

  def expired?
    self[:exp] <= Time.now.to_i
  end

  def provider
    self[:sub].split("|").first
  end

  def user_id_from_provider
    self[:sub].split("|").last
  end
end
