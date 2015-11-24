module Api
  class IdentitiesController < ApplicationController
    skip_after_action :verify_authorized

    def new
      @identity = request.env.fetch("omniauth.identity") || Identity.new
      render json: @identity, location: nil
    end
  end
end
