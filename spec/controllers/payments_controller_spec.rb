require "spec_helper"

describe Api::PaymentsController, type: :controller do
  describe "GET #index" do
    it "should query 2 Payments" do
      user = create(:user)
      login(user)
      payment = create_list(:payment,
                            2,
                            user: user).first
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Payment" do
      user = create(:user)
      login(user)
      payment = create(:payment,
                       user: user)
      get(
        :show,
        id: payment.id)

      expect(json.keys).to include("transaction_id")
    end
  end

  describe "POST #create" do
    before do
      user = create(:user)
      login(user)
    end

    context "with valid attributes" do
      it "should create Payment" do
        payment_attributes =
          attributes_for(:payment)

        expect do
          post(
            :create,
            payment: payment_attributes)
        end.to change(Payment, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Payment" do
        payment_attributes =
          attributes_for(:payment, amount: nil)

        expect do
          post(
            :create,
            payment: payment_attributes)
        end.to change(Payment, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    before do
      user = create(:user)
      @payment = create(:payment,
                        user: user)

      admin = create(:administrator)
      login(admin)
    end

    context "with valid attributes" do
      it "should update Payment" do
        amount = @payment.amount + rand(1..100)

        patch(
          :update,
          id: @payment.id,
          payment: { amount: amount })

        expect(Payment.find(@payment.id).amount).to eq(amount)
      end
    end

    context "with invalid attributes" do
      it "should not update Payment" do
        patch(
          :update,
          id: @payment.id,
          payment: { amount: nil })

        expect(Payment.find(@payment.id).amount).to eq(@payment.amount)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Payment" do
      user = create(:user)
      payment = create(:payment,
                       user: user)
      admin = create(:administrator)
      login(admin)

      expect do
        delete(
          :destroy,
          id: payment.id)
      end.to change(Payment, :count).by(-1)
    end
  end
end
