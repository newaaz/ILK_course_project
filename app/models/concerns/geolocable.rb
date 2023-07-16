module Geolocable
  extend ActiveSupport::Concern
  included do
    COORDINATES_OPTIONAL = %w[Activity].freeze

    has_one :geolocation, as: :geolocable, dependent: :destroy
    accepts_nested_attributes_for :geolocation, reject_if: :coordinates_optional?

    def nearby_objects(object, count = 10)
      lat_range = (geolocation.latitude - 0.0090)..(geolocation.latitude + 0.0090)
      long_range = (geolocation.longitude - 0.0127)..(geolocation.longitude + 0.0127)

      object.constantize.activated
                        .select(:id, :title)
                        .with_attached_avatar
                        .includes([:geolocation])
                        .where(town_id: self.town_id)
                        .joins(:geolocation)
                        .where(geolocation: { latitude: lat_range, longitude: long_range, geolocable_type: object })
                        .where.not(geolocation: { geolocable_id: id })
                        .take(count)
    end

    def distance_to(object)
      (90000 * Math.sqrt((geolocation.latitude - object.geolocation.latitude)**2 + (geolocation.longitude - object.geolocation.longitude)**2)).floor(-1)
    end

    def coordinates_optional?
      COORDINATES_OPTIONAL.include?(model_name.name)
    end
  end
end
