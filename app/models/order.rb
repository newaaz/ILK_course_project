class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :property
  belongs_to :room

  validates :check_in, :check_out, presence: true
end
