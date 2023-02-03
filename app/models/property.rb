class Property < ApplicationRecord
  include Imagable
  include Geolocable

  # search with oficial gem
  include Searchable
  
  belongs_to :owner, class_name: 'Partner'
  belongs_to :town
  belongs_to :category

  has_many  :rooms, dependent: :destroy
  has_many  :orders, dependent: :destroy

  validates :title, :address, presence: true

  # search with searchkick    
  searchkick

  scope :search_import, -> { includes(:rooms, :orders) }

  def search_data
    {
      title:                title,
      town_id:              town_id,
      category_id:          category_id,
      rooms:                self.room_availabilities    # from searchable
    }
  end


end
