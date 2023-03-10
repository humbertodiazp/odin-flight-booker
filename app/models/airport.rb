class Airport < ApplicationRecord
    has_many :flights
    has_many :bookings
end
