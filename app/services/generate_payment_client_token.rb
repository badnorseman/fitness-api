class GenerateClientTokenForPayment
  def initialize()
  end

  def call
    Braintree::ClientToken.generate
  end
end
