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
  
  belongs_to :owner, class_name: 'Partner'
  belongs_to :town
  belongs_to :category

  has_one  :property_detail, dependent: :destroy
  has_many :rooms, dependent: :destroy  
  has_many :orders, dependent: :destroy  
  has_many :bookings, dependent: :destroy

  #TODO move to concern
  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact

  validates :title, :address, presence: true

  scope :by_category, ->(category) { joins(:category).where(category: { title: category }) }

  accepts_nested_attributes_for :property_detail  
end
