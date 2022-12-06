class Price < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :day_cost, presence: true
end
