require "spec_helper"

describe "Session", type: :request do
  describe "when user logs in" do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:facebook, { uid: "1234" })
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

      get("/api/auth/facebook/callback")
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
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
