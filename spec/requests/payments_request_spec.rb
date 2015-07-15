require "spec_helper"

describe Payment, type: :request do
  context "when authenticated" do
    describe "GET #index" do
      before do
        user = create(:user)
        login(user)
        create_list(:payment,
                    2,
                    user: user).first
        get("/api/payments.json")
      end

      it "should respond with an array of 2 Payments" do
        expect(json.count).to eq 2
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      before do
        user = create(:user)
        login(user)
        @payment = create(:payment,
                          user: user)
        get("/api/payments/#{@payment.id}.json")
      end

      it "should respond with 1 Payment" do
        expect(json["amount"]).to eq(@payment.amount.as_json)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      before do
        user = create(:user)
        login(user)

        get("/api/payments/new.json")
      end

      it "should respond with new client token" do
        expect(json.keys).to include("client_token")
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      before do
        user = create(:user)
        login(user)
      end

      context "with valid attributes" do
        before do
          product = create(:product)
          @payment_attributes =
            attributes_for(:payment,
                           amount: 10000,
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: product.id)
          puts " "
          puts "START ==================================================="
          puts " "
          post(
            "/api/payments.json",
            { payment: @payment_attributes })
          puts " "
          puts "END ==================================================="
          puts " "
        end

        it "should respond with created Payment" do
          expect(json["amount"]).to eq(@payment.amount)
        end

        it "should respond with new id" do
          expect(json.keys).to include("id")
        end

        it "should respond with status 201" do
          expect(response.status).to eq 201
        end
      end

      context "with invalid attributes" do
        before do
          payment_attributes =
            attributes_for(:payment,
                           amount: nil)
          post(
            "/api/payments.json",
            { payment: payment_attributes })
        end

        it "should respond with errors" do
          expect(json.keys).to include("errors")
        end

        it "should respond with status 422" do
          expect(response.status).to eq 422
        end
      end

      context "with consumed nonce" do
        before do
          payment_attributes =
            attributes_for(:payment,
                           :consumed_nonce)
          post(
            "/api/payments.json",
            { payment: payment_attributes })
        end

        it "should respond with errors" do
          expect(json.keys).to include("errors")
        end

        it "should respond with status 422" do
          expect(response.status).to eq 422
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
        before do
          @amount = 120

          patch(
            "/api/payments/#{@payment.id}.json",
            { payment: { amount: @amount }})
        end

        it "should respond with updated Payment" do
          expect(json["amount"]).to eq(@amount)
        end

        it "should respond with status 200" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid attributes" do
        before do
          patch(
            "/api/payments/#{@payment.id}.json",
            { payment: { amount: nil }})
        end

        it "should respond with errors" do
          expect(json.keys).to include("errors")
        end

        it "should respond with status 422" do
          expect(response.status).to eq 422
        end
      end
    end

    describe "DELETE #destroy" do
      before do
        user = create(:user)
        @payment = create(:payment,
                          user: user)
        admin = create(:administrator)
        login(admin)

        delete("/api/payments/#{@payment.id}.json")
      end

      it "should respond with status 204" do
        expect(response.status).to eq 204
      end
    end
  end

  context "when unauthenticated" do
    before do
      get "/api/payments.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end
end
