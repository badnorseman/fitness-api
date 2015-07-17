require "spec_helper"

describe HabitDescription, type: :request do
  context "when authenticated" do
    before do
      coach = create(:coach)
      login(coach)
      @habit_description = create_list(:habit_description,
                                       2,
                                       user: coach).first
    end

    describe "GET #index" do
      before do
        get("/api/habit_descriptions.json")
      end

      it "should respond with array of 2 HabitDescriptions" do
        expect(json.count).to eq 2
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      before do
        get("/api/habit_descriptions/#{@habit_description.id}.json")
      end

      it "should respond with 1 HabitDescription" do
        expect(json["name"]).to eq(@habit_description.name)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        before do
          @habit_description_attributes = attributes_for(:habit_description, tag_list: "")

          post(
            "/api/habit_descriptions.json",
            { habit_description: @habit_description_attributes })
        end

        it "should respond with created HabitDescription" do
          expect(json["name"]).to eq @habit_description_attributes[:name]
        end

        it "should respond with Tags for created HabitDescription" do
          expect(json["tag_list"]).to eq @habit_description_attributes[:tag_list]
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
          habit_description_attributes =
            attributes_for(:habit_description, name: nil)

          post(
            "/api/habit_descriptions.json",
            { habit_description: habit_description_attributes })
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
      context "with valid attributes" do
        before do
          @name = "NAME #{rand(100)}"
          @tag_list = ""

          patch(
            "/api/habit_descriptions/#{@habit_description.id}.json",
            { habit_description: { name: @name, tag_list: @tag_list }})
        end

        it "should respond with updated HabitDescription" do
          expect(json["name"]).to eq @name
        end

        it "should respond with Tags for updated HabitDescription" do
          expect(json["tag_list"]).to eq(@tag_list)
        end

        it "should respond with status 200" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid attributes" do
        before do
          name = "EXCEEDS MAX LENGTH" * 100

          patch(
            "/api/habit_descriptions/#{@habit_description.id}.json",
            { habit_description: { name: name }})
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
        delete("/api/habit_descriptions/#{@habit_description.id}.json")
      end

      it "should respond with status 204" do
        expect(response.status).to eq 204
      end
    end
  end

  context "when unauthenticated" do
    before do
      get "/api/habit_descriptions.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end
end
