class VerifyToken
  def initialize(authorization:)
    token = get_token_from(authorization)
    decoded_token = decode(token)
    verified_token = verify(decoded_token)
  end

  def call
  end

  private

  def get_token_from(authorization)
    begin
      raise InvalidTokenError if authorization.nil?
      token = authorization.split(" ").last
      token
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
  end

  def decode(token)
    Token.decode(token)
  end

  def verify(token)
    begin
      raise InvalidTokenError if !token.client_id_valid?
      raise InvalidTokenError if !token.issuer_valid?
      raise InvalidTokenError if token.expired?
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
  end
end
