class Geolocation < ApplicationRecord
  COORDINATES_OPTIONAL = %w[Activity Service].freeze

  belongs_to :geolocable, polymorphic: true
  validates :latitude, :longitude, presence: true, unless: -> { COORDINATES_OPTIONAL.include?(self.geolocable_type) }
  
  #after_validation :reverse_geocode
  reverse_geocoded_by :latitude, :longitude
end
