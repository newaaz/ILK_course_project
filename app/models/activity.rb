class Activity < ApplicationRecord  

  ACTIVITY_CATEGORIES = ["Морские прогулки", "Воздушные прогулки", "Конные прогулки", "Джипинг", "Рыбалка", "Рыбалка", "Другое"]

  SERVICE_CATEGORIES =  ["Доставка еды", "Такси", "Спортзалы", "Стадионы", "Рынки"]

  include CarrierwaveImagable
  include Geolocable
  include ListingActivatable
  include Contactable

  has_and_belongs_to_many :towns

  belongs_to :owner, class_name: 'Partner'

  validates :title, :category_title, :description, presence: true
end
