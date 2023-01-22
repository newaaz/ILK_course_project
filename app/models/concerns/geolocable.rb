module Geolocable
  extend ActiveSupport::Concern
  included do
    has_one :geolocation, as: :geolocable, dependent: :destroy
    accepts_nested_attributes_for :geolocation, reject_if: :coordinates_optional?

    def nearby_objects(object)
      min_lat, max_lat = (geolocation.latitude - 0.0090), (geolocation.latitude + 0.0090)
      min_long, max_long = (geolocation.longitude - 0.0127), (geolocation.longitude + 0.0127)

      points = Geolocation.where(latitude: min_lat..max_lat, longitude: min_long..max_long, geolocable_type: object)
                          .where.not(geolocable_type: object, geolocable_id: id)

      points.map do |point|
        {
          title: point.geolocable.title,
          object_id: point.geolocable.id,
          distance: distance_to(point)
        }
      end 
    end

    private

    def coordinates_optional?
      #TODO set name for array optional_models
      %w[Activity].include?(model_name.name)
    end

    def distance_to(point)
      (120000 * Math.sqrt((geolocation.latitude - point.latitude)**2 + (geolocation.longitude - point.longitude)**2)).floor(-1)
    end
  end
end
