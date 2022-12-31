module Geolocable
  extend ActiveSupport::Concern
  included do
    has_one :geolocation, as: :geolocable, dependent: :destroy
    accepts_nested_attributes_for :geolocation, reject_if: :coordinates_optional?

    private

    def coordinates_optional?
      #TODO set name for array optional_models
      %w[Activity].include?(model_name.name)
    end
  end
end
