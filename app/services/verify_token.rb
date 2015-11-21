class VerifyToken
  def initialize(authorization:)
    token = get_token_from_http_header(authorization)
    decoded_token = decode(token)
    @token = NewToken.new(decoded_token)
  end

  def call
    begin
      raise InvalidTokenError if !@token.is_valid?
    rescue JWT::DecodeError
      raise InvalidTokenError
    end
    @token
  end

  private

  # How can I access request.headers["Authorization"]?
  # request.env.fetch("HTTP_AUTHORIZATION")
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
    decoded_token = JWT.decode(token,
      JWT.base64url_decode(
        Rails.application.secrets.auth0_client_secret)
    )[0]
    decoded_token
  end
end
