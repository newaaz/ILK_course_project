class Activity < ApplicationRecord  
  # ACTIVITY_CATEGORIES =  {
  #   sea: 'Морские прогулки',
  #   sky: 'Воздушные прогулки',
  #   horse: 'Конные прогулки',
  #   jeeping: 'Джиппинг',
  #   fishing: 'Рыбалка',
  #   diving: 'Дайвинг',
  #   other_activity: 'Другое',
  # }

  ACTIVITY_CATEGORIES = ["Морские прогулки", "Воздушные прогулки", "Конные прогулки", "Джипинг",]

  SERVICE_CATEGORIES =  {
    sea: 'Кухня',
    sky: 'Экскурсии',
    horse: 'Бассеин',
    food_delivery: 'Парковка',
    taxi: 'Детская площадка',
  }

  include CarrierwaveImagable
  include Geolocable
  include ListingActivatable
  include Contactable

  has_and_belongs_to_many :towns

  belongs_to :owner, class_name: 'Partner'

  validates :title, :category_title, :description, presence: true
end
