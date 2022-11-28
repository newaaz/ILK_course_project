class Room < ApplicationRecord
  include Imagable

  belongs_to :property

  validates :avatar, :images, :property_id, :guest_base_count, :guest_max_count, presence: true
end
