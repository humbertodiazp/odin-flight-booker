# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails dbseed command (or created alongside the database with dbsetup).
#
# Examples
#
#   movies = Movie.create([{ name "Star Wars" }, { name "Lord of the Rings" }])
#   Character.create(name "Luke", movie movies.first)

TOP_TEN_FLIGHT_DURATIONS = {
  :ATL => { :DFW => 135, :DEN => 190, :ORD => 93, :LAX => 150, :CLT => 75, :MCO => 90, :LAS => 250, :PHX => 235, :MIA => 115 },
  :DFW => { :ATL => 175, :DEN => 125, :ORD => 145, :LAX => 190, :CLT => 155, :MCO => 160, :LAS => 170, :PHX => 145, :MIA => 175 },
  :DEN => { :ATL => 130, :DFW => 115, :ORD => 150, :LAX => 150, :CLT => 200, :MCO => 220, :LAS => 115, :PHX => 115, :MIA => 235 },
  :ORD => { :ATL => 120, :DFW => 140, :DEN => 155, :LAX => 260, :CLT => 120, :MCO => 165, :LAS => 230, :PHX => 220, :MIA => 185 },
  :LAX => { :ATL => 265, :DFW => 190, :DEN => 145, :ORD => 250, :CLT => 295, :MCO => 300, :LAS => 75, :PHX => 90, :MIA => 320 },
  :CLT => { :ATL => 75, :DFW => 160, :DEN => 215, :ORD => 125, :LAX => 295, :MCO => 100, :LAS => 275, :PHX => 255, :MIA => 120 },
  :MCO => { :ATL => 95, :DFW => 165, :DEN => 235, :ORD => 180, :LAX => 295, :CLT => 310, :LAS => 295, :PHX => 265, :MIA => 70 },
  :LAS => { :ATL => 240, :DFW => 165, :DEN => 115, :ORD => 220, :LAX => 75, :CLT => 260, :MCO => 285, :PHX => 70, :MIA => 295 },
  :PHX => { :ATL => 225, :DFW => 145, :DEN => 110, :ORD => 210, :LAX => 85, :CLT => 250, :MCO => 260, :LAS => 70, :MIA => 275 }, 
  :MIA => { :ATL => 120, :DFW => 185, :DEN => 265, :ORD => 205, :LAX => 320, :CLT => 130, MCO => 75, 'LAS' 315, 'PHX' 285 }
 }.freeze
 
 MAX_FLIGHTS_PER_ROUTE = 5
 
 def seed_airports
   TOP_TEN_FLIGHT_DURATIONS.each_key { |code| Airport.create(code: code) }
 end
 
 def seed_flight(day, departure_airport, arrival_airport)
   Flight.create(
     departure_time: add_random_time_to_day(day),
     duration_in_min: TOP_TEN_FLIGHT_DURATIONS[departure_airport][arrival_airport],
     departure_airport_id: Airport.find_by(code: departure_airport).id,
     arrival_airport_id: Airport.find_by(code: arrival_airport).id
   )
 end
 
 def add_random_time_to_day(day)
   day.to_datetime + rand(0..23).hours + rand(0..59).minutes
 end
 
 def seed_random_number_of_flights_on_day(day, departure_airport, arrival_airport)
   rand(0..MAX_FLIGHTS_PER_ROUTE).times do
     seed_flight(day, departure_airport, arrival_airport)
   end
 end
 
 def seed_flights
   current_date = Date.today
   (current_date..current_date + 1.year).each do |day|
     TOP_TEN_FLIGHT_DURATIONS.each_key do |departure_airport|
       TOP_TEN_FLIGHT_DURATIONS[departure_airport].each_key do |arrival_airport|
         seed_random_number_of_flights_on_day(day, departure_airport, arrival_airport)
       end
     end
   end
 end
 
 Flight.destroy_all
 Airport.destroy_all
 seed_airports
 seed_flights
