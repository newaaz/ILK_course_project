class Room < ApplicationRecord
  include Imagable
  
  belongs_to :property

  has_many :prices, -> { order(:start_date) }, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :title, :guest_base_count, :guest_max_count, presence: true
  validate  :check_overlap_price_date_ranges

  accepts_nested_attributes_for :prices, reject_if: :all_blank, allow_destroy: true

  #TODO validates_each
  def check_overlap_price_date_ranges
    all_prices = self.prices.to_a
    if all_prices.count > 1
      compare_price = all_prices.shift
      all_prices.each do |price|
        errors.add(:prices, "- there are intersect date ranges in prices") if compare_price.date_range.overlaps? price.date_range
      end
    end
  end

  def start_available_date
    prices.any? ? prices.minimum(:start_date) : nil
  end

  def end_available_date
    prices.any? ? prices.maximum(:end_date) : nil
  end
end
