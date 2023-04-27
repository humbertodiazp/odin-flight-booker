class FlightsController < ApplicationController
  def index
    if params && all_search_params_present_and_not_empty? && given_valid_date? && given_upcoming_date? && !same_airports?
      @flights = Flight.search(params)
    elsif params[:searching]
      if !all_search_params_present_and_not_empty?
        flash.now.alert = "All fields in the search form are required."
      elsif !given_upcoming_date?
        flash.now.alert = "This date has already passed."
      elsif !given_valid_date?
        flash.now.alert = "Invalid date."
      elsif same_airports?
        flash.now.alert = "The departure and arrival airports cannot be the same."
      end
    end
  end

  private

  def all_search_params_present_and_not_empty?
    [:departure_airport_id, :arrival_airport_id, :ticket_num, "time(2i)", "time(3i)", "time(1i)"].all? do |key|
      params.has_key?(key) && !params[key].empty?
    end
  end

  def given_valid_date?
    begin
      Flight.array_to_date(params['time(2i)'], params['time(3i)'], params['time(1i)'])
    rescue ArgumentError
      return false
    end
  end

  def given_upcoming_date?
    Flight.array_to_date(params['time(2i)'], params['time(3i)'], params['time(1i)']) >= Date.today
  end

  def same_airports?
    params[:departure_airport_id] == params[:arrival_airport_id]
  end
end