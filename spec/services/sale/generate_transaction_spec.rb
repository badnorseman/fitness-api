describe Sale::CreateTransaction do
  context "with valid payment method nonce" do
    it "should create transaction" do
      amount = 100
      payment_method_nonce = "fake-valid-nonce"

      transaction = Sale::CreateTransaction.new(
        amount: amount,
        payment_method_nonce: payment_method_nonce).call

      expect(transaction.success?).to be_truthy
    end
  end

  context "with consumed payment method nonce" do
    it "shouldn't create transaction" do
      amount = 100
      payment_method_nonce = "fake-consumed-nonce"

      transaction = Sale::CreateTransaction.new(
        amount: amount,
        payment_method_nonce: payment_method_nonce).call

      expect(transaction.success?).to be_falsey
    end
  end
end
