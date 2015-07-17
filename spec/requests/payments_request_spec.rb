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
        expect(json.keys).to include("transaction_id")
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
        it "should respond with created Payment" do
          payment_attributes =
            attributes_for(:payment,
                           amount: rand(1..1899),
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: 1)
          post(
            "/api/payments.json",
            { payment: payment_attributes })

            expect(json.keys).to include("transaction_id")
        end

        it "should respond with new id" do
          payment_attributes =
            attributes_for(:payment,
                           amount: rand(1..1899),
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: 1)
          post(
            "/api/payments.json",
            { payment: payment_attributes })

          expect(json.keys).to include("id")
        end

        it "should respond with status 201" do
          payment_attributes =
            attributes_for(:payment,
                           amount: rand(1..1899),
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: 1)
          post(
            "/api/payments.json",
            { payment: payment_attributes })

          expect(response.status).to eq 201
        end
      end

      context "with invalid attributes" do
        it "should respond with errors" do
          payment_attributes =
            attributes_for(:payment,
                           amount: nil,
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: 1)
          post(
            "/api/payments.json",
            { payment: payment_attributes })

          expect(json.keys).to include("errors")
        end

        it "should respond with status 422" do
          payment_attributes =
            attributes_for(:payment,
                           amount: nil,
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: 1)
          post(
            "/api/payments.json",
            { payment: payment_attributes })

          expect(response.status).to eq 422
        end
      end

      context "with consumed nonce" do
        it "should respond with errors" do
          payment_attributes =
            attributes_for(:payment,
                           amount: rand(3001..4000),
                           currency: "USD",
                           payment_method_nonce: "fake-consumed-nonce",
                           product_id: 1)
          post(
            "/api/payments.json",
            { payment: payment_attributes })

          expect(json.keys).to include("errors")
        end

        it "should respond with status 422" do
          payment_attributes =
            attributes_for(:payment,
                           amount: rand(3001..4000),
                           currency: "USD",
                           payment_method_nonce: "fake-consumed-nonce",
                           product_id: 1)
          post(
            "/api/payments.json",
            { payment: payment_attributes })

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
          amount = @payment.amount + rand(1..100)

          patch(
            "/api/payments/#{@payment.id}.json",
            { payment: { amount: amount }})
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
