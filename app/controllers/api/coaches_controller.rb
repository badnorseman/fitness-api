module Api
  class CoachesController < ApplicationController
    skip_before_action :restrict_access, only: [:index]
    before_action :set_coach, only: :schedule
    skip_after_action :verify_policy_scoped

    # GET /coaches.json
    def index
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
