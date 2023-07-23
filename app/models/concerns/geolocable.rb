module Geolocable
  extend ActiveSupport::Concern
  included do
    has_one :geolocation, as: :geolocable, dependent: :destroy
    accepts_nested_attributes_for :geolocation, reject_if: :blank_location_optional?

    def nearby_objects(object, count = 10)
      lat_range = (geolocation.latitude - 0.0090)..(geolocation.latitude + 0.0090)
      long_range = (geolocation.longitude - 0.0127)..(geolocation.longitude + 0.0127)

      if coordinates_optional?(object) || coordinates_optional?(self.model_name.name)
        object.constantize.activated
                          .select(:id, :title, object == 'Property' ? nil : :avatar)
                          .includes([:geolocation])
                          .joins(:geolocation)
                          .where(geolocation: { latitude: lat_range, longitude: long_range, geolocable_type: object })
                          .where.not(geolocation: { geolocable_id: id })
                          .take(count)
      else
        object.constantize.activated
                          .select(:id, :title)
                          .includes([:geolocation])
                          .where(town_id: self.town_id)
                          .joins(:geolocation)
                          .where(geolocation: { latitude: lat_range, longitude: long_range, geolocable_type: object })
                          .where.not(geolocation: { geolocable_id: id })
                          .take(count)
      end


    end

    def distance_to(object)
      (90000 * Math.sqrt((geolocation.latitude - object.geolocation.latitude)**2 + (geolocation.longitude - object.geolocation.longitude)**2)).floor(-1)
    end

    private

    def blank_location_optional?(attributes)
      (attributes[:latitude].blank? || attributes[:longitude].blank?) && coordinates_optional?(self.model_name.name)
    end

    def coordinates_optional?(object)
      Geolocation::COORDINATES_OPTIONAL.include?(object)
    end
  end
end
