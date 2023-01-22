class Order < ApplicationRecord
  before_validation :booking_calculate, on: :create, if: :dates_present?

  belongs_to :customer
  belongs_to :property
  belongs_to :room

  validates :check_in, :check_out, presence: true
  validate  :correct_arrival_dates,           on: :create, if: :dates_present?
  validate  :available_by_prices_date_ranges, on: :create, if: :dates_present?
  validate  :available_by_booked_orders,      on: :create, if: :dates_present?



  enum status: { received: 0, accepted: 1, rejected: 2, paid: 3 }

  protected

  def order_date_range
    check_in..check_out
  end

  private

  attr_accessor :available_days_by_prices

  def dates_present?
    check_in.present? && check_out.present?
  end

  def booking_calculate
    self.available_days_by_prices = 0

    self.room.prices.each do |price|
      calculate_intersection(price) if price.date_range.overlaps? order_date_range
    end
  end

  def calculate_intersection(price)
    price_day_count = ([check_in, price.start_date].max..[check_out, price.end_date].min).count
    self.total_amount += price_day_count * price.day_cost
    self.available_days_by_prices += price_day_count
  end

  def available_by_prices_date_ranges
    errors.add(:date_range, "- availability is limited.") unless order_date_range.count == available_days_by_prices 
  end

  def available_by_booked_orders
    self.property.orders.where(room: self.room, status: 'accepted').each do |booked_order|
      errors.add(:date_range, "Arrival dates are booked") if self.order_date_range.overlaps? booked_order.order_date_range
    end
  end

  def correct_arrival_dates
    errors.add(:check_in, "should be earlier check out") if check_in >= check_out
  end
end
