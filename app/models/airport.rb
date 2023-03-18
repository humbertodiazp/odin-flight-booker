class Airport < ApplicationRecord
    default_scope { order(:code) }
  
    validates :code, presence: true, length: { is: 3 }
  
    has_many :departure_flights, class_name: 'Flight', foreign_key: 'departure_airport_id', inverse_of: :departure_airport
    has_many :arrival_flights, class_name: 'Flight', foreign_key: 'arrival_airport_id', inverse_of: :arrival_airport
  end