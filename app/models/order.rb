class Order < ApplicationRecord
  belongs_to :property
  belongs_to :customer

  validates :check_in, :check_out, presence: true
end
