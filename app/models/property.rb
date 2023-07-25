class Property < ApplicationRecord
  SERVICES =  {
                kitchen: 'Кухня',
                excursions: 'Экскурсии',
                pool: 'Бассеин',
                parking: 'Парковка',
                playground: 'Детская площадка',
              }.freeze

  include Imagable
  include Geolocable
  include Searchable
  include ListingActivatable
  include Contactable
  
  belongs_to :owner, class_name: 'Partner'
  belongs_to :town
  belongs_to :category

  has_one  :property_detail, dependent: :destroy
  has_many :rooms, dependent: :destroy  
  has_many :orders, dependent: :destroy  
  has_many :bookings, dependent: :destroy

  validates :title, :address, presence: true
  validates :price_from, numericality: { greater_than: 0, less_than: 999999 }
  validates :distance_to_sea, numericality: { allow_nil: true, greater_than: 0, less_than: 30000 }

  scope :by_category, ->(category) { joins(:category).where(category: { title: category }) }

  accepts_nested_attributes_for :property_detail  
end
