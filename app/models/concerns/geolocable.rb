module Geolocable
  extend ActiveSupport::Concern
  included do
    has_one :geolocation, as: :geolocable, dependent: :destroy
    accepts_nested_attributes_for :geolocation

    def nearby_objects(object)
      lat_range = (geolocation.latitude - 0.0090)..(geolocation.latitude + 0.0090)
      long_range = (geolocation.longitude - 0.0127)..(geolocation.longitude + 0.0127)

      object.constantize.includes([:geolocation, avatar_attachment: :blob])
                        .where(town_id: self.town_id)
                        .joins(:geolocation)
                        .where(geolocation: { latitude: lat_range, longitude: long_range, geolocable_type: object })
                        .where.not(geolocation: { geolocable_id: id })
    end

    def distance_to(object)
      (90000 * Math.sqrt((geolocation.latitude - object.geolocation.latitude)**2 + (geolocation.longitude - object.geolocation.longitude)**2)).floor(-1)
    end
  end
end
