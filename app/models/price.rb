class Price < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :day_cost, presence: true
  validate  :check_start_end_dates 

  def date_range
    start_date..end_date
  end

  private

  def check_start_end_dates
    errors.add(:start_date, "should be earlier end date") if start_date >= end_date
  end
end
