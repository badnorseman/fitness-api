require "spec_helper"

describe Api::TransactionsController, type: :controller do
  describe "GET #index" do
    it "should query 2 Transactions" do
      user = create(:user)
      login(user)
      product = create(:product)
      create_list(:transaction,
                  2,
                  product: product.id,
                  user: user).first
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Transaction" do
      user = create(:user)
      login(user)
      product = create(:product)
      transaction = create(:transaction,
                           product_id: product.id,
                           user: user)
      get(
        :show,
        id: transaction.id)

      expect(json.keys).to include("id")
    end
  end

  describe "POST #create" do
    before do
      @user = create(:user)
      login(@user)
      @product = create(:product)
    end

    context "with valid attributes" do
      it "should create Transaction" do
        transaction_attributes =
          attributes_for(:transaction,
                         product_id: @product.id,
                         user: @user)

        expect do
          post(
            :create,
            transaction: transaction_attributes)
        end.to change(Transaction, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Transaction" do
        transaction_attributes =
          attributes_for(:transaction,
                         amount: nil,
                         product_id: @product.id,
                         user: @user)

        expect do
          post(
            :create,
            transaction: transaction_attributes)
        end.to change(Transaction, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    before do
      user = create(:user)
      product = create(:product)
      @transaction = create(:transaction,
                            product_id: product.id,
                            user: user)

      admin = create(:administrator)
      login(admin)
    end

    context "with valid attributes" do
      it "should update Transaction" do
        amount = @transaction.amount + rand(1..100)

        patch(
          :update,
          id: @transaction.id,
          transaction: { amount: amount })

        expect(Transaction.find(@transaction.id).amount).to eq(amount)
      end
    end

    context "with invalid attributes" do
      it "should not update Transaction" do
        patch(
          :update,
          id: @transaction.id,
          transaction: { amount: nil })

        expect(Transaction.find(@transaction.id).amount).to eq(@transaction.amount)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Transaction" do
      user = create(:user)
      product = create(:product)
      transaction = create(:transaction,
                           product_id: product.id,
                           user: user)
      admin = create(:administrator)
      login(admin)

      expect do
        delete(
          :destroy,
          id: transaction.id)
      end.to change(Transaction, :count).by(-1)
    end
  end
end
