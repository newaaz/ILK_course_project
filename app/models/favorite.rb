class Favorite < ApplicationRecord
  has_many :favorite_items, dependent: :destroy
  has_many :properties, through: :favorite_items, source: :listing, source_type: "Property"
  has_many :activities, through: :favorite_items, source: :listing, source_type: "Activity"
  has_many :services, through: :favorite_items, source: :listing, source_type: "Service"
  has_many :places, through: :favorite_items, source: :listing, source_type: "Place"
  has_many :food_places, through: :favorite_items, source: :listing, source_type: "FoodPlace"

end
