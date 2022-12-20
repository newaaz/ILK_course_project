module Imagable
  extend ActiveSupport::Concern

  included do
    has_one_attached  :avatar  
    has_many_attached :images
    #validates :avatar, :images, presence: true 

    #TODO ActiveStorage validation
    
    def avatar_thumb
      avatar.variant(resize_to_limit: [200, 200])
    end

    def image_thumb(image)
      image.variant(resize_to_limit: [100, 100])
    end
  end
end
