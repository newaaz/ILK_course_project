class Property < ApplicationRecord
  include Imagable

  belongs_to  :owner
  belongs_to  :town
  belongs_to  :category

  has_one_attached  :avatar  

  validates :title, :avatar, :latitude, :longitude, presence: true
end
