class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(allowed_post_params)
    if @booking.save
      redirect_to @booking, notice: 'Your flight was successfully booked.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private 
  
  def allowed_post_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
  end
end