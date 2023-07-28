class Partner < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :confirmable,
          :lockable

  has_many :properties, foreign_key: 'owner_id', class_name: 'Property', dependent: :destroy
  has_many :activities, foreign_key: 'owner_id', class_name: 'Activity', dependent: :destroy
  has_many :services, foreign_key: 'owner_id', class_name: 'Service', dependent: :destroy
  has_many :places, foreign_key: 'owner_id', class_name: 'Place', dependent: :destroy
  has_many :restaurants, foreign_key: 'owner_id', class_name: 'Restaurant', dependent: :destroy
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
