module Imagable
  extend ActiveSupport::Concern

  included do
    has_one_attached  :avatar  
    has_many_attached :images

    validates :avatar, attached: true, content_type: ['image/png', 'image/jpeg', 'image/jpg'],
                size: { less_than: 5.megabytes, message: '. Изображение должно быть меньше 5 Мб' }

    validates :images, attached: true, content_type: ['image/png', 'image/jpeg', 'image/jpg'],
                size: { less_than: 5.megabytes, message: '. Изображение должно быть меньше 5 Мб' },
                limit: { min: 1, max: 35, message: '. Макимальное количество изображений 35' }
     
    def avatar_thumb
      avatar.variant(resize_to_limit: [200, 200])
    end

    def image_thumb(image)
      image.variant(resize_to_limit: [100, 100])
    end
  end
end
