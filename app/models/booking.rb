class Booking < ApplicationRecord
  has_many :flights
  belongs_to :passanger 
end
