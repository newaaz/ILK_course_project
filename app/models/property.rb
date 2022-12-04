class Property < ApplicationRecord
  belongs_to :owner, class_name: 'Partner'
  belongs_to :town
  belongs_to :category 

  validates :title, :address, presence: true
end
