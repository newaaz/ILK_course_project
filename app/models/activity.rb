class Activity < ApplicationRecord
  SERVICES =  {
    sea: 'Кухня',
    sky: 'Экскурсии',
    horse: 'Бассеин',
    food_delivery: 'Парковка',
    taxi: 'Детская площадка',
  }.freeze

  include CariersaveImagable
  include Geolocable
  include ListingActivatable
  include Contactable

  has_and_belongs_to_many :towns

  belongs_to :owner, class_name: 'Partner'
end
