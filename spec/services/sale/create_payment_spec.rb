describe Sale::CreatePayment do
  context "with valid attributes" do
    it "should be created" do
      user = create(:user)
      product = create(:product)
      params = { user: user,
                  amount: 10000,
                  currency: "USD",
                  payment_method_nonce: "fake-valid-nonce",
                  product_id: product.id }

      expect do
        Sale::CreatePayment.new(user: user, params: params).call
      end.to change(Payment, :count).by(1)
    end
  end

  context "with invalid attributes" do
    it "shouldn't be created" do
      user = create(:user)
      product = create(:product)
      params = { user: user,
                  amount: nil,
                  currency: "USD",
                  payment_method_nonce: "fake-consumed-nonce",
                  product_id: product.id }

      expect do
        Sale::CreatePayment.new(user: user, params: params).call
      end.to change(Payment, :count).by(0)
    end
  end

  context "with consumed payment method nonce" do
    it "shouldn't be created" do
      user = create(:user)
      product = create(:product)
      params = { user: user,
                  amount: 10000,
                  currency: "USD",
                  payment_method_nonce: "fake-consumed-nonce",
                  product_id: product.id }

      expect do
        Sale::CreatePayment.new(user: user, params: params).call
      end.to change(Payment, :count).by(0)
    end
  end
end
