describe Sale::CreateSaleTransaction do
  context "with valid payment method nonce" do
    it "should create transaction" do
      amount = rand(1..1899)
      customer = create(:user)
      merchant_account_id = "fitbirdUSD"
      payment_method_nonce = "fake-valid-nonce"

      transaction = Sale::CreateSaleTransaction.new(
        amount: amount,
        customer: customer,
        merchant_account_id: merchant_account_id,
        payment_method_nonce: payment_method_nonce).call

      expect(transaction.success?).to be_truthy
    end
  end

  context "with consumed payment method nonce" do
    it "shouldn't create transaction" do
      amount = rand(3001..4000)
      customer = create(:user)
      merchant_account_id = "fitbirdUSD"
      payment_method_nonce = "fake-consumed-nonce"

      transaction = Sale::CreateSaleTransaction.new(
        amount: amount,
        customer: customer,
        merchant_account_id: merchant_account_id,
        payment_method_nonce: payment_method_nonce).call

      expect(transaction.success?).to be_falsey
    end
  end
end
