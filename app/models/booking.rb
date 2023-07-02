class Booking < ApplicationRecord
  belongs_to :property  
  belongs_to :guest, class_name: 'Partner', foreign_key: 'guest_id', inverse_of: :as_guest_bookings

  has_one :hoster, through: :property, source: :owner
end
