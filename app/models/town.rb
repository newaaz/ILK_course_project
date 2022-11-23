class Town < ApplicationRecord
  mount_uploader  :avatar, PictureUploader

  validates :name, :parent_name, :number, :avatar, presence: true  
  validate  :avatar_size

  default_scope { order(:number) }

  private

  def avatar_size    
    errors.add(:avatar, "- изображение должно быть меньше 4 МБ") if avatar.size > 4.megabytes
  end
end
