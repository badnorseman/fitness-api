describe Sale::CreateTransaction do
  context "with valid attributes" do
    it "should be created" do
      user = create(:user)
      product = create(:product)
      params = { user: user,
                 amount: rand(1..1899),
                 currency: "USD",
                 payment_method_nonce: "fake-valid-nonce",
                 product_id: product.id }

      expect do
        Sale::CreateTransaction.new(user: user, params: params).call
      end.to change(Transaction, :count).by(1)
    end
  end

  context "with invalid amount" do
    it "shouldn't be created" do
      user = create(:user)
      product = create(:product)
      params = { user: user,
                 amount: nil,
                 currency: "USD",
                 payment_method_nonce: "fake-valid-nonce",
                 product_id: product.id }

      expect do
        Sale::CreateTransaction.new(user: user, params: params).call
      end.to change(Transaction, :count).by(0)
    end
  end

  context "with invalid currency" do
    it "shouldn't be created" do
      user = create(:user)
      product = create(:product)
      params = { user: user,
                 amount: rand(1..1899),
                 currency: "",
                 payment_method_nonce: "fake-valid-nonce",
                 product_id: product.id }

      expect do
        Sale::CreateTransaction.new(user: user, params: params).call
      end.to change(Transaction, :count).by(0)
    end
  end

  context "with consumed payment method nonce" do
    it "shouldn't be created" do
      user = create(:user)
      product = create(:product)
      params = { user: user,
                 amount: rand(3001..4000),
                 currency: "USD",
                 payment_method_nonce: "fake-consumed-nonce",
                 product_id: product.id }

      expect do
        Sale::CreateTransaction.new(user: user, params: params).call
      end.to change(Transaction, :count).by(0)
    end
  end
end
