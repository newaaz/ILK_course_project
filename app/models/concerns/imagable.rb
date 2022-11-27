module Imagable
  extend ActiveSupport::Concern

  included do
    has_many_attached :images
    validates :images, presence: true
    #validate  :image_size

    private

    def image_size
      errors.add(:images, "- общее количество - не больше 35 фотографий") if images.count > 35
      if images.any?
        images.each do |image|        
          errors.add(:images, "- одно или несколько изображений превышают допустимый размер - 4 МБ") if image.size > 4.megabytes
        end   
      end
    end
  end
end
