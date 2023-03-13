class Town < ApplicationRecord
  has_many  :properties, dependent: :destroy

  mount_uploader  :avatar, PictureUploader

  validates :name, :parent_name, :ordinal_number, presence: true  

  default_scope { order(:ordinal_number) }
end
