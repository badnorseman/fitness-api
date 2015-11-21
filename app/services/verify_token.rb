class VerifyToken
  def initialize(authorization:)
    token = get_token_from_http_header(authorization)
    @decoded_token = Token.decode(token)
    verify_decoded_token
    # How can I change this from DecodedToken and Token to Token only?
    # decoded_token = decode(token)
    # @token = Token.new(decoded_token)
    # - Delete Token and rename DecodedToken to Token
  end

  def call
    @decoded_token
  end

  private

  # How can I access request.headers["Authorization"]?
  def get_token_from_http_header(authorization)
    begin
      raise InvalidTokenError if authorization.nil?
      token = authorization.split(" ").last
      token
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
  end

  # How can I access Rails.application.secrets.auth0_client_secret)?
  def decode(token)
    JWT.decode(
      token,
      JWT.base64url_decode(
        Rails.application.secrets.auth0_client_secret)
    )[0])
  end

  # Is this correct or should I use fail instead?
  def verify_decoded_token
    begin
      raise InvalidTokenError if !@decoded_token.client_id_valid?
      raise InvalidTokenError if !@decoded_token.issuer_valid?
      raise InvalidTokenError if @decoded_token.expired?
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
  end
end
