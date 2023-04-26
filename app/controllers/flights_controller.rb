class FlightsController < ApplicationController
  before_action :set_flights, only: [:index]

  def index
    if params[:searching]
      if all_search_params_present_and_not_empty? && given_valid_date? && given_upcoming_date? && !same_airports?
        @flights = Flight.search(params)
      else
        handle_search_error
      end
    end
  end

  private

  def set_flights
    @flights = Flight.all
  end

  def all_search_params_present_and_not_empty?
    [:departure_airport_id, :arrival_airport_id, :num_tickets, "time(2i)", "time(3i)", "time(1i)"].all? do |key|
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

  def handle_search_error
    flash.now.alert = "Error: "
    flash.now.alert += "All fields in the search form are required. " unless all_search_params_present_and_not_empty?
    flash.now.alert += "This date has already passed. " unless given_upcoming_date?
    flash.now.alert += "Invalid date. " unless given_valid_date?
    flash.now.alert += "The departure and arrival airports cannot be the same." if same_airports?
  end
end
