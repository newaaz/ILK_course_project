module Imagable
  extend ActiveSupport::Concern

  included do
    has_one_attached  :avatar  
    has_many_attached :images
    validates :avatar, :images, presence: true


    
  end
end
