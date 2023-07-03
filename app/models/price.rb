class Price < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :day_cost, presence: true
  validate  :check_start_end_dates, if: :dates_present?

  def date_range
    start_date..end_date
  end

  private

  def dates_present?
    start_date.present? && end_date.present?
  end

  def check_start_end_dates
    errors.add(:start_date, "должна быть раньше даты оконачания") if start_date >= end_date
  end
end
