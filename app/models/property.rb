class Property < ApplicationRecord
  include Imagable
  
  belongs_to :owner, class_name: 'Partner'
  belongs_to :town
  belongs_to :category 

  has_many  :rooms, dependent: :destroy

  validates :title, :address, presence: true
end
