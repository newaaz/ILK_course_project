class Activity < ApplicationRecord  
  ACTIVITY_CATEGORIES = [ "Морские прогулки", "Воздушные прогулки", "Конные прогулки",
                          "Джипинг", "Рыбалка", "Другое"]

  SERVICE_CATEGORIES =  ["Доставка еды", "Такси", "Спортзалы", "Стадионы", "Рынки"]

  include CarrierwaveImagable
  include Geolocable
  include ListingActivatable
  include Contactable
  include AdditionalFieldable

  has_and_belongs_to_many :towns

  belongs_to :owner, class_name: 'Partner'

  validates :title, :category_title, :description, :towns, presence: true
  validates :category_title, inclusion: { in: ACTIVITY_CATEGORIES }
  #validate :geolocation_with_addres

  private

  def geolocation_with_addres
    errors.add(:address, "При указанном расположении на карте должен быть указан адрес") if self.geolocation.present? && self.address.blank?
  end
end
