class Room < ApplicationRecord
  SERVICES =  {
    sea_view: 'Вид на море',
    mountain_view: 'Вид на горы',
    balcony: 'Балкон',
    wifi: 'WiFi',
    tv: 'Телевизор',
    satellite: 'Спутниковое, цифровое ТВ',
    fridge: 'Холодильник',
    conditioner: 'Кондиционер',
    kettle: 'Эл чайник'
  }.freeze

  include Imagable

  after_save -> { self.property.reindex } 
  
  belongs_to :property

  has_many :prices, -> { order(:start_date) }, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :title, :guest_base_count, :guest_max_count, :serial_number, :rooms_count, :size, presence: true
  validates :serial_number, :guest_base_count, :guest_max_count, :rooms_count, :size, numericality: { greater_than: 0, less_than: 9999 }
  validate  :check_overlap_price_date_ranges

  accepts_nested_attributes_for :prices, allow_destroy: true

  def self.sample_data(room_id)
    if room_id == 0
      Room.new(prices: [Price.new])
    else
      original_room = Room.find(room_id)
      sample_room = original_room.dup

      original_room.prices.each do |price|
        price.day_cost = nil
        sample_room.prices << price.dup
      end
  
      sample_room
    end
  end

  def check_overlap_price_date_ranges
    all_prices = self.prices.to_a
    while all_prices.count > 1
      compare_price = all_prices.shift
      all_prices.each do |price|
        errors.add(:prices, "- есть пересечение в датах") if compare_price.date_range.overlaps? price.date_range
      end
    end
  end

  def calculate_booking(check_in, check_out)
    check_in = check_in.to_date
    check_out = check_out.to_date

    total_cost = 0

    self.prices.each do |price|
      if price.date_range.overlaps? check_in..check_out
        overlap_days_count = ([check_in, price.start_date].max..[check_out, price.end_date].min).count
        total_cost += overlap_days_count * price.day_cost
      end
    end
    
    total_cost
  end

  def start_available_date
    prices.any? ? prices.minimum(:start_date) : nil
  end

  def end_available_date
    prices.any? ? prices.maximum(:end_date) : nil
  end

  def min_price
    prices.any? ? prices.minimum(:day_cost) : nil
  end
end
