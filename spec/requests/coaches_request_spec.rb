require "spec_helper"

describe "Coach", type: :request do
  context "when authenticated" do
    before do
      user = create(:user)
      login(user)
      @coach = create_list(:coach, 2).first
    end

    describe "GET list of coaches " do
      before do
        get("/api/coaches.json")
      end

      it "should respond with array of 2 coaches" do
        expect(json.count).to eq 2
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    describe "GET schedule of coach" do
      before do
        create(:availability,
               coach: @coach,
               start_at: Time.zone.now,
               end_at: 1.week.from_now)
        get("/api/coaches/#{@coach.id}/schedule.json")
      end

      it "should respond with schedule that has 8 days" do
        expect(json.keys.count).to eq 8
      end

      it "should respond with schedule that begins today" do
        expect(json.keys.first).to eq Time.zone.now.to_date.to_s
      end
    end
  end
end
