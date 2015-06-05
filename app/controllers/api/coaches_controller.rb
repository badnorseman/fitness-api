module Api
  class CoachesController < ApplicationController
    before_action :set_coach, only: :schedule

    # GET /coaches.json
    def index
      # render json: User.coaches.data_for_listing, status: :ok
      render json: Coach.data_for_listing, status: :ok
    end

    # GET /coaches/:id/schedule
    def schedule
      render json: Scheduler::ReconciledSchedule.new(coach: @coach).to_hash
    end

    def set_coach
      @coach = User.find(coach_id)
      authorize @coach
    end

    def coach_id
      params.fetch(:coach_id)
    end
  end
end
