class Flight < ApplicationRecord
  belongs_to :departure_airport
  belongs_to :arrival_airport
end
