class Property < ApplicationRecord
  include Imagable
  include Geolocable
  include Searchable
  
  belongs_to :owner, class_name: 'Partner'
  belongs_to :town
  belongs_to :category

  has_many :rooms, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one  :property_detail, dependent: :destroy

  validates :title, :address, presence: true

  scope :by_category, ->(category) { joins(:category).where(category: { title: category }) }
end
