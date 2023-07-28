class Place < ApplicationRecord
  PLACE_CATEGORIES = ["Пляжи", "Достопримечательности", "Парки", "Кинотеатры", "Музеи", "Театры", "Рынки", "Места для фото",
                      "Спортивные площадки", "Другое"]

  belongs_to :owner, class_name: 'Partner'
  belongs_to :town

  include CarrierwaveImagable
  include Geolocable
  include ListingActivatable
  include Contactable
  include AdditionalFieldable

  validates :title, :category_title, :description, :town_id, presence: true
  validates :category_title, inclusion: { in: PLACE_CATEGORIES }
end
