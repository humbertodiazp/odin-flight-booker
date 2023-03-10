class BookingsController < ApplicationController
  def new
    @booking = Flight.booking_options[search_params]  )
  end

  def create
    @booking = Flight.booking_options[search_params]  )
    
    respond_to do |format|
      if @booking.save
        
        format.html { redirect_to booking_url(@booking), notice: "Booking succesfully created." }
        format.json { render :show, status: :created, location: @booking }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  