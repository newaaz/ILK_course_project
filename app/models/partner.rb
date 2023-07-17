class Partner < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :confirmable
          
  has_many :properties, foreign_key: 'owner_id', class_name: 'Property', dependent: :destroy
  has_many :as_hoster_bookings, through: :properties, source: :bookings
  has_many :as_guest_bookings, class_name: 'Booking', foreign_key: 'guest_id', inverse_of: :guest, dependent: :destroy

  mount_uploader  :avatar, PictureUploader

  def owner_orders
    Order.where(property_id: property_ids)
  end

  def admin?
    email == Rails.application.credentials.email[:admin]
  end

  def name_or_email
    name.presence || email.split('@').first
  end
end
