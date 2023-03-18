class FlightsController < ApplicationController
  def index
    @airport_options = Airport.select(:airport, :name).order(:airport).page(params[:page])

    if search_params.present?
      if departure_airport == arrival_airport
        flash.now[:alert] = "Departure and arrival airports cannot be the same"
      else
        @booking_options = BookingOptions.new(search_params).find_flights
      end
    end
  end

  private

  def search_params
    params.permit(:departure_airport, :arrival_airport, :departure_time)
  end

  def departure_airport
    @departure_airport ||= Airport.find_by(id: params[:name])
  end

  def arrival_airport
    @arrival_airport ||= Airport.find_by(id: params[:arrival_airport_id])
  end
end