class Customer < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :confirmable

  has_many  :orders, dependent: :destroy
end
