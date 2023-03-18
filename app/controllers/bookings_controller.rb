class BookingsController < ApplicationController
    def new
      @booking = Booking.new
    end
  
    def show
      @booking = Booking.find(params[:id])
    end
  
    def create
      @booking = Booking.new(search_params)
      if @booking.save
        redirect_to @booking, notice: 'Your flight was successfully booked.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private 
    
    def search_params
      params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
    end
end


  