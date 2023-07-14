class Booking < ApplicationRecord
  after_create :send_booking_creating_email

  belongs_to :property  
  belongs_to :guest, class_name: 'Partner', foreign_key: 'guest_id', inverse_of: :as_guest_bookings

  has_one :hoster, through: :property, source: :owner

  validates :guest_name, presence: true
  
  private

  def send_booking_creating_email
    ListingMailer.booking_created(self).deliver_later
  end  
end
