
class FlightsController < ApplicationController
    def index
      @airport_options = Airport.all.map { |u| [u.location, u.id] }
      return if search_params.empty?
  
      @booking_options = find_booking_options
    end
  
    private
  
      def search_params
        params.permit(:departure_airport_id, :arrival_airport_id, :departure_time)
      end
  
      def find_booking_options
        if params[:departure_airport_id] == params[:arrival_airport_id]
          flash.now[:alert] = "Invalid selection, please try again!"
          render :index
        else
          BookingOptions.new(search_params).find_flights
        end
      end
  end