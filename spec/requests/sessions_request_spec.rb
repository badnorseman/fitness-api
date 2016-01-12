require "spec_helper"

describe "Session", type: :request do
  describe "log in with email" do
    before do
      identity = create(:identity)

      get(
        "/api/auth/identity/callback",
        { auth_key: identity.email,
          password: identity.password,
          name: "NAME#{rand(1000)}" })
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "failure to log in with email" do
    before do
      get(
        "/api/auth/identity/callback",
        { auth_key: nil })
    end

    it "should respond with invalid credentials" do
      expect(response.headers["Location"]).to include("invalid_credentials")
    end
  end

  describe "log in with facebook" do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(
        :facebook, {
          uid: "1234",
            info: { email: "USER#{rand(1000)}@FITBIRD.COM" }})
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

      get("/api/auth/facebook/callback")
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "log out" do
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
