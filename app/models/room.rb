class Room < ApplicationRecord
  belongs_to :property

  validates :title, :guest_base_count, :guest_max_count, presence: true
end
