class Price < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :day_cost, presence: true

  def date_range
    start_date..end_date
  end
end
