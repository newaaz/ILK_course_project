module BookingCalculatable
  extend ActiveSupport::Concern

  included do
    def total_amount
      @total_amount || calculate_total_booking
    end

    private
  
    attr_writer :total_amount
  
    def order_date_range
      check_in..check_out
    end
  
    def calculate_total_booking
      self.total_amount = 0
  
      self.room.prices.each do |price|
        break calculate_price_cover_order(price) if price.date_range.cover? order_date_range
        (calculate_order_start_in_price(price) and next) if price.date_range.include? self.check_in
        (calculate_order_cover_price(price) and next) if order_date_range.cover? price.date_range
        (calculate_order_end_in_price(price) and next) if price.date_range.include? self.check_out
      end
  
      self.total_amount
    end
  
    # TODO Refactor: merge in 1 function with 2 args?
    def calculate_price_cover_order(price)
      self.total_amount += order_date_range.count * price.day_cost
    end
  
    def calculate_order_start_in_price(price)
      self.total_amount += (self.check_in..price.end_date).count * price.day_cost
    end
  
    def calculate_order_cover_price(price)
      self.total_amount += price.date_range.count * price.day_cost
    end
  
    def calculate_order_end_in_price(price)
      self.total_amount += (price.start_date..self.check_out).count * price.day_cost
    end
  end
end
