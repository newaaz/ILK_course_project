class Partner < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable
        # :confirmable
          
  has_many :properties, foreign_key: 'owner_id', class_name: 'Property', dependent: :destroy

  def owner_orders
    Order.where(property_id: property_ids)
  end
end
