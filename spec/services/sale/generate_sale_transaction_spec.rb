describe Sale::CreateSaleTransaction do
  context "with valid payment method nonce" do
    it "should create transaction" do
      amount = rand(1..1899)
      customer_name = "CUSTOMER_NAME#{rand(1000)}"
      merchant_account_id = "fitbirdUSD"
      merchant_name = "MERCHANT_NAME#{rand(1000)}"
      payment_method_nonce = "fake-valid-nonce"
      product_name = "PRODUCT_NAME#{rand(1000)}"

      transaction = Sale::CreateSaleTransaction.new(
        amount: amount,
        customer_name: customer_name,
        merchant_account_id: merchant_account_id,
        merchant_name: merchant_name,
        payment_method_nonce: payment_method_nonce,
        product_name: product_name).call

      expect(transaction.success?).to be_truthy
    end
  end

  context "with consumed payment method nonce" do
    it "shouldn't create transaction" do
      amount = rand(3001..4000)
      customer_name = "CUSTOMER_NAME#{rand(1000)}"
      merchant_account_id = "fitbirdUSD"
      merchant_name = "MERCHANT_NAME#{rand(1000)}"
      payment_method_nonce = "fake-consumed-nonce"
      product_name = "PRODUCT_NAME#{rand(1000)}"

      transaction = Sale::CreateSaleTransaction.new(
        amount: amount,
        customer_name: customer_name,
        merchant_account_id: merchant_account_id,
        merchant_name: merchant_name,
        payment_method_nonce: payment_method_nonce,
        product_name: product_name).call

      expect(transaction.success?).to be_falsey
    end
  end
end
