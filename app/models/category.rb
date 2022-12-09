class Category < ApplicationRecord
  has_many :properties, dependent: :destroy
  default_scope { order(:ordinal_number) }
  validates :title, :ordinal_number, presence: true
end
