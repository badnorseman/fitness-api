require "spec_helper"

describe ExerciseSetLog, type: :request do
  before do
    @user = create(:user)
    @coach = create(:coach)
    exercise_plan_log = create(:exercise_plan_log,
                                user: @user,
                                coach: @coach)
    @exercise_session_log = create(:exercise_session_log,
                                   exercise_plan_log: exercise_plan_log,
                                   user: @user,
                                   coach: @coach)
    @exercise_set_log = create_list(:exercise_set_log,
                                    2,
                                    exercise_session_log: @exercise_session_log,
                                    user: @user,
                                    coach: @coach).first
  end

  context "when authenticated" do
    describe "GET #show" do
      before do
        login(@user)

        get("/api/exercise_set_logs/#{@exercise_set_log.id}.json")
      end

      it "should respond with 1 ExerciseSetLog" do
        expect(json["duration"]).to eq(@exercise_set_log.duration)
      end

      it "should respond with status 200" do
        expect(response.status).to eq(200)
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        before do
          login(@coach)

          @exercise_set_log_attributes =
            attributes_for(:exercise_set_log,
                           duration: rand(45..120),
                           exercise_session_log_id: @exercise_session_log.id,
                           user_id: @user.id,
                           coach_id: @coach.id,
                           exercise_session_log_id: @exercise_session_log.id)
          post(
            "/api/exercise_set_logs.json",
            { exercise_set_log: @exercise_set_log_attributes })
        end

        it "should respond with created ExerciseSetLog" do
          expect(json["duration"]).to eq @exercise_set_log_attributes[:duration]
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
          login(@coach)

          exercise_set_log_attributes =
            attributes_for(:exercise_set_log,
                           user_id: @user.id,
                           coach_id: @coach.id)
          post(
            "/api/exercise_set_logs.json",
            { exercise_set_log: exercise_set_log_attributes })
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

          @duration = rand(45..120)

          patch(
            "/api/exercise_set_logs/#{@exercise_set_log.id}.json",
            { exercise_set_log: { duration: @duration }})
        end

        it "should respond with updated ExerciseSetLog" do
          expect(json["duration"]).to eq @duration
        end

        it "should respond with status 200" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid attributes" do
        before do
          login(@user)

          patch(
            "/api/exercise_set_logs/#{@exercise_set_log.id}.json",
            { exercise_set_log: { exercise_session_log_id: "" }})
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

        delete("/api/exercise_set_logs/#{@exercise_set_log.id}.json")
      end

      it "should respond with status 204" do
        expect(response.status).to eq 204
      end
    end
  end

  context "when unauthenticated" do
    before do
      get "/api/exercise_set_logs/#{@exercise_set_log.id}.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end
end
