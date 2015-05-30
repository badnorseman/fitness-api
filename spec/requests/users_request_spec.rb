require "spec_helper"

describe User, type: :request do
  before do
    user = create(:administrator)
    login(user)
  end

  describe "GET list of users" do
    before do
      create_list(:user, 2)
      get("/api/users.json")
    end

    it "should respond with array of 3 users" do
      expect(json.count).to eq 3
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  # context "when unauthenticated" do
  #   before do
  #     get "/api/users.json"
  #   end
  #
  #   it "should respond with status 401" do
  #     expect(response.status).to eq 401
  #   end
  # end
end
