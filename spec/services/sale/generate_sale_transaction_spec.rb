describe Sale::CreateSaleTransaction do
  context "with valid payment method nonce" do
    it "should create transaction" do
      amount = 100
      payment_method_nonce = "fake-valid-nonce"

      transaction = Sale::CreateSaleTransaction.new(
        amount: amount,
        payment_method_nonce: payment_method_nonce).call

      expect(transaction: :transaction_id).to be_truthy
    end
  end

  context "with invalid payment method nonce" do
    it "shouldn't create transaction" do
      amount = 100
      payment_method_nonce = "fake-consumed-nonce"

      transaction = Sale::CreateSaleTransaction.new(
        amount: amount,
        payment_method_nonce: payment_method_nonce).call

      expect(transaction: :errors).to be_truthy
    end
  end
end
