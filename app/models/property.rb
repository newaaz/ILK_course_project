class Property < ApplicationRecord
  include Imagable

  belongs_to  :owner
  belongs_to  :town
  belongs_to  :category

  has_many  :rooms, dependent: :destroy

  validates :title, :latitude, :longitude, presence: true
end
