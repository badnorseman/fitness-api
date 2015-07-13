# Merge confirm into update
module Api
  class BookingsController < ApplicationController
    before_action :set_booking, only: [:show, :update, :destroy, :confirm]

    # GET /bookings.json
    def index
      render json: policy_scope(Booking), status: :ok
    end

    # GET /bookings/1.json
    def show
      render json: @booking, status: :ok
    end

    # POST /bookings.json
    def create
      @booking = CreateBooking.new(user: current_user, params: booking_params).call
      authorize @booking

      if @booking.persisted?
        render json: @booking, status: :created
      else
        render json: { errors: @booking.errors }, status: :unprocessable_entity
      end
    end

    # PUT /bookings/1.json
    def update
      @booking.assign_attributes(booking_params)

      if @booking.save
        render json: @booking, status: :ok
      else
        render json: { errors: @booking.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /bookings/1.json
    def destroy
      if @booking.update(canceled_at: Time.zone.now, canceled_by: current_user.id)
        render json: @booking
      else
        render json: { errors: @booking.errors }, status: :unprocessable_entity
      end
    end

    # POST /bookings/1/confirm.json
    def confirm
      if @booking.update(confirmed_at: Time.zone.now)
        render json: @booking
      else
        render json: { errors: @booking.errors }, status: :unprocessable_entity
      end
    end

    private

    def booking_params
      params.require(:booking).
        permit(:coach_id,
               :start_at,
               :end_at)
    end

    def set_booking
      @booking = Booking.find(booking_id)
      authorize @booking
    end

    def booking_id
      params.fetch(:id)
    end
  end
end
