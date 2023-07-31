module CarrierwaveImagable
  extend ActiveSupport::Concern

  included do
    MAX_SIZE = 4.megabytes.freeze
    mount_uploader  :avatar, ListingUploader
    mount_uploaders :images, ListingUploader

    validates :avatar, :images, presence: true
    validate  :avatar_size 
    validate  :images_size

    private

    def avatar_size
      errors.add(:avatar, "- изображение должно быть меньше #{MAX_SIZE} МБ") if avatar.size > MAX_SIZE
    end

    def images_size
      errors.add(:images, "- общее количество - не больше 35 фотографий") if images.count > 35
      if images.any?
        images.each do |image|        
          errors.add(:images, "- одно или несколько изображений превышают допустимый размер - 4 МБ") if image.size > MAX_SIZE
        end   
      end
    end
  end
end
