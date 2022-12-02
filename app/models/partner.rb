class Partner < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable
          
  has_many :properties, foreign_key: 'owner_id', class_name: 'Property', dependent: :destroy
end
