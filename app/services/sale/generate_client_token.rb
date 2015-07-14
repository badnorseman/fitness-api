module Sale
  class GenerateClientToken
    def initialize
      @client_token = generate_client_token
    end

    def client_token
      @client_token
    end

    private

    def generate_client_token
      Braintree::ClientToken.generate
    end
  end
end
