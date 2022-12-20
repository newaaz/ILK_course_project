class Geolocation < ApplicationRecord
  belongs_to :geolocable, polymorphic: true  
  validates :latitude, :longitude, presence: true
  
  #after_validation :reverse_geocode
  reverse_geocoded_by :latitude, :longitude
end
