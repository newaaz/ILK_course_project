class Town < ApplicationRecord
  has_many  :properties, dependent: :destroy
  has_and_belongs_to_many :activities

  mount_uploader  :avatar, PictureUploader

  validates :name, :parent_name, :ordinal_number, presence: true  

  default_scope { order(:ordinal_number) }
end
