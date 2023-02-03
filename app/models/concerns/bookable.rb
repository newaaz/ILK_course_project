module Bookable
  extend ActiveSupport::Concern

  included do
    before_validation :booking_calculate,       on: :create, if: :dates_present?

    validate  :correct_arrival_dates,           on: :create, if: :dates_present?
    validate  :available_by_prices_date_ranges, on: :create, if: :dates_present?
    validate  :available_by_booked_orders,      on: :create, if: :dates_present?

    private

    attr_accessor :available_days_by_prices

    def dates_present?
      check_in.present? && check_out.present?
    end

    def correct_arrival_dates
      errors.add(:check_in, "should be earlier check out") if check_in >= check_out
    end

    def available_by_prices_date_ranges
      errors.add(:date_range, "- availability is limited.") unless self.date_range.count == available_days_by_prices 
    end
  
    def available_by_booked_orders
      self.property.orders.where(room: self.room, status: 'accepted').each do |booked_order|
        errors.add(:date_range, "Arrival dates are booked") if self.date_range.overlaps? booked_order.date_range
      end
    end

    def booking_calculate
      self.available_days_by_prices = 0
  
      self.room.prices.each do |price|
        calculate_intersection(price) if price.date_range.overlaps? self.date_range
      end
    end
  
    def calculate_intersection(price)
      price_day_count = ([check_in, price.start_date].max..[check_out, price.end_date].min).count
      self.total_amount += price_day_count * price.day_cost
      self.available_days_by_prices += price_day_count
    end
  end
end
