require "spec_helper"

describe ExerciseLog, type: :request do
  before do
    @user = create(:user)
    @coach = create(:coach)
    @exercise_description = create(:exercise_description,
                                   user: @coach)
    @exercise_log = create_list(:exercise_log,
                                2,
                                exercise_description: @exercise_description,
                                user: @user,
                                coach: @coach).first
  end

  context "when authenticated" do
    describe "GET #show" do
      before do
        login(@user)

        get("/api/exercise_logs/#{@exercise_log.id}.json")
      end

      it "should respond with 1 ExerciseLog" do
        expect(json["load"]).to eq(@exercise_log.load.as_json)
      end

      it "should respond with status 200" do
        expect(response.status).to eq(200)
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        before do
          login(@coach)

          @exercise_log_attributes =
            attributes_for(:exercise_log,
                           exercise_description_id: @exercise_description.id,
                           user_id: @user.id,
                           coach: @coach)
          post(
            "/api/exercise_logs.json",
            { exercise_log: @exercise_log_attributes })
        end

        it "should respond with created ExerciseLog" do
          expect(json["load"]).to eq @exercise_log_attributes[:load].to_json
        end

        it "should respond with status 201" do
          expect(response.status).to eq 201
        end
      end

      context "with invalid attributes" do
        before do
          login(@coach)

          exercise_log_attributes =
            attributes_for(:exercise_log, tempo: "too long value")

          post(
            "/api/exercise_logs.json",
            { exercise_log: exercise_log_attributes,
              exercise_description_id: @exercise_description.id })
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
          login(@user)

          @tempo = "12X#{rand(100)}"

          patch(
            "/api/exercise_logs/#{@exercise_log.id}.json",
            { exercise_log: { tempo: @tempo }})
        end

        it "should respond with updated ExerciseLog" do
          expect(json["tempo"]).to eq @tempo
        end

        it "should respond with status 200" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid attributes" do
        before do
          login(@user)

          tempo = "too long value" * 100

          patch(
            "/api/exercise_logs/#{@exercise_log.id}.json",
            { exercise_log: { tempo: tempo }})
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
        login(@coach)

        delete("/api/exercise_logs/#{@exercise_log.id}.json")
      end

      it "should respond with status 204" do
        expect(response.status).to eq 204
      end
    end
  end

  context "when unauthenticated" do
    before do
      get "/api/exercise_logs/#{@exercise_log.id}.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end
end
