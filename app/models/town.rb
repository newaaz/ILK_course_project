class Town < ApplicationRecord
  has_many  :properties, dependent: :destroy
  has_many  :places, dependent: :destroy
  has_many  :food_places, dependent: :destroy
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :services

  mount_uploader  :avatar, PictureUploader

  validates :name, :parent_name, :ordinal_number, presence: true  

  default_scope { order(:ordinal_number) }
end
