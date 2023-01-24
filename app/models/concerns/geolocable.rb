module Geolocable
  extend ActiveSupport::Concern
  included do
    has_one :geolocation, as: :geolocable, dependent: :destroy
    accepts_nested_attributes_for :geolocation

    def nearby_objects(object)
      min_lat, max_lat = (geolocation.latitude - 0.0090), (geolocation.latitude + 0.0090)
      min_long, max_long = (geolocation.longitude - 0.0127), (geolocation.longitude + 0.0127)

      nearbys_geolocations = Geolocation.where(latitude: min_lat..max_lat, longitude: min_long..max_long, geolocable_type: object)
                                 .where.not(geolocable_type: object, geolocable_id: id)
                                 .order(:updated_at)
      
      nearbys_objects = object.constantize.order(:updated_at).find(nearbys_geolocations.pluck(:geolocable_id))

      nearbys_objects.map.with_index do |object, i|
        {
          title: object.title,
          object_id: object.id,
          distance: distance_to(nearbys_geolocations[i])
        }
      end
    end

    private

    def distance_to(point)
      (120000 * Math.sqrt((geolocation.latitude - point.latitude)**2 + (geolocation.longitude - point.longitude)**2)).floor(-1)
    end
  end
end
