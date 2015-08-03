require "spec_helper"

describe Transaction, type: :request do
  context "when authenticated" do
    describe "GET #index" do
      before do
        user = create(:user)
        login(user)
        create_list(:transaction,
                    2,
                    user: user).first
        get("/api/transactions.json")
      end

      it "should respond with an array of 2 Transactions" do
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
        @transaction = create(:transaction,
                              user: user)
        get("/api/transactions/#{@transaction.id}.json")
      end

      it "should respond with 1 Transaction" do
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

        get("/api/transactions/new.json")
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
        it "should respond with created Transaction" do
          product = create(:product)
          transaction_attributes =
            attributes_for(:transaction,
                           amount: rand(1..1899),
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: product.id)
          post(
            "/api/transactions.json",
            { transaction: transaction_attributes })

            expect(json.keys).to include("transaction_id")
        end

        it "should respond with new id" do
          product = create(:product)
          transaction_attributes =
            attributes_for(:transaction,
                           amount: rand(1..1899),
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: product.id)
          post(
            "/api/transactions.json",
            { transaction: transaction_attributes })

          expect(json.keys).to include("id")
        end

        it "should respond with status 201" do
          product = create(:product)
          transaction_attributes =
            attributes_for(:transaction,
                           amount: rand(1..1899),
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: product.id)
          post(
            "/api/transactions.json",
            { transaction: transaction_attributes })

          expect(response.status).to eq 201
        end
      end

      context "with invalid attributes" do
        it "should respond with errors" do
          product = create(:product)
          transaction_attributes =
            attributes_for(:transaction,
                           amount: nil,
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: product.id)
          post(
            "/api/transactions.json",
            { transaction: transaction_attributes })

          expect(json.keys).to include("errors")
        end

        it "should respond with status 422" do
          product = create(:product)
          transaction_attributes =
            attributes_for(:transaction,
                           amount: nil,
                           currency: "USD",
                           payment_method_nonce: "fake-valid-nonce",
                           product_id: product.id)
          post(
            "/api/transactions.json",
            { transaction: transaction_attributes })

          expect(response.status).to eq 422
        end
      end

      context "with consumed nonce" do
        it "should respond with errors" do
          product = create(:product)
          transaction_attributes =
            attributes_for(:transaction,
                           amount: rand(3001..4000),
                           currency: "USD",
                           payment_method_nonce: "fake-consumed-nonce",
                           product_id: product.id)
          post(
            "/api/transactions.json",
            { transaction: transaction_attributes })

          expect(json.keys).to include("errors")
        end

        it "should respond with status 422" do
          product = create(:product)
          transaction_attributes =
            attributes_for(:transaction,
                           amount: rand(3001..4000),
                           currency: "USD",
                           payment_method_nonce: "fake-consumed-nonce",
                           product_id: product.id)
          post(
            "/api/transactions.json",
            { transaction: transaction_attributes })

          expect(response.status).to eq 422
        end
      end
    end

    describe "PATCH #update" do
      before do
        user = create(:user)
        @transaction = create(:transaction,
                              user: user)
        admin = create(:administrator)
        login(admin)
      end

      context "with valid attributes" do
        before do
          amount = @transaction.amount + rand(1..100)

          patch(
            "/api/transactions/#{@transaction.id}.json",
            { transaction: { amount: amount }})
        end

        it "should respond with status 200" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid attributes" do
        before do
          patch(
            "/api/transactions/#{@transaction.id}.json",
            { transaction: { amount: nil }})
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
        @transaction = create(:transaction,
                              user: user)
        admin = create(:administrator)
        login(admin)

        delete("/api/transactions/#{@transaction.id}.json")
      end

      it "should respond with status 204" do
        expect(response.status).to eq 204
      end
    end
  end

  context "when unauthenticated" do
    before do
      get "/api/transactions.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end
end
