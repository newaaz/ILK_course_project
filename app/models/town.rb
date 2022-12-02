class Town < ApplicationRecord
  has_many  :properties, dependent: :destroy

  #has_one_attached  :avatar

  validates :name, :parent_name, :ordinal_number, presence: true  

  default_scope { order(:ordinal_number) }
end
