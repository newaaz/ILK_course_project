module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 } do
      mapping dynamic: false do
        indexes :id,          type: :long
        indexes :town_id,     type: :long
        indexes :category_id, type: :long
        indexes :title,       type: :text
        indexes :activated,   type: :boolean
        indexes :rooms, type: :nested, properties: {
                  id:               { type: :long },
                  title:            { type: :text },
                  guest_base_count: { type: :byte },
                  guest_max_count:  { type: :byte },                  
                  start_available:  { type: :date },
                  end_available:    { type: :date },
                  prices:           { type: :nested, properties: {
                    start_date: { type: :date },
                    end_date:   { type: :date },
                    day_cost:   { type: :long }
                  }}
        }
      end
    end

    def as_indexed_json(_options = {})
      self.as_json(
            only: %i[id title town_id category_id]
          ).merge({
              rooms: room_availabilities
            })
    end

    def room_availabilities
      if rooms.any?
        rooms.map do |room|
          {
            guest_base_count: room.guest_base_count,
            guest_max_count:  room.guest_max_count,
            id:               room.id,
            start_available:  room.start_available_date,
            end_available:    room.end_available_date,
            prices:           room.prices.map do |price|
                                {
                                  start_date: price.start_date,
                                  end_date:   price.end_date,
                                  day_cost:   price.day_cost
                                }
            end
          }
        end
      end
    end

    # Searchkick
    searchkick
    scope :search_import, -> { includes(:rooms) }

    def search_data
      {
        title:                title,
        town_id:              town_id,
        category_id:          category_id,
        activated:            activated,
        rooms:                self.room_availabilities   
      }
    end
  end
end
