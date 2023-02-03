class Order < ApplicationRecord
  include Bookable
  include Statusable

  belongs_to :customer
  belongs_to :property
  belongs_to :room

  validates :check_in, :check_out, presence: true

  def date_range
    check_in..check_out
  end
end
