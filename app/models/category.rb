class Category < ApplicationRecord
  #has_many :properties, dependent: :destroy
  default_scope { order(:number) }
  validates :title, :number, presence: true
end
