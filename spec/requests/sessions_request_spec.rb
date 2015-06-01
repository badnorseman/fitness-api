require "spec_helper"

describe "Session", type: :request do
  describe "when user logs in" do
    context "with valid credentials" do
      before do
        post(
          "/api/auth/identity/callback",
          { auth_key: "agent.smith@matrix.com",
            password: "dammit" })
      end

      it "should respond with status 200" do
        expect(response.status).to eq(200)
      end
    end

    context "with invalid credentials" do
      before do
        post(
          "/api/auth/identity/callback",
          { auth_key: "agent.smith@matrix.com",
            password: nil })
      end

      it "should respond with status 401" do
        expect(response.status).to eq(401)
      end
    end
  end

  describe "when user logs out" do
    before do
      user = create(:user)
      login(user)

      get("/api/logout")
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end
end
