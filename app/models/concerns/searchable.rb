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
        indexes :available_range, type: :nested, properties: {
                    available_start_date: { type: :date },
                    available_end_date:   { type: :date },
                    min_price:            { type: :long },
                    max_price:            { type: :long }
                  }
        indexes :rooms, type: :nested, properties: {
                  guest_base_count: { type: :byte },
                  guest_max_count:  { type: :byte },
                  title:            { type: :text },
                  id:               { type: :long },
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
            only: %i[id town_id category_id]
          ).merge({
              rooms: room_availabilities
          }).merge({
              available_range: price_date_available_range
          })
    end

    def room_availabilities
      if rooms.any?
        rooms.map do |room|
          {
            guest_base_count: room.guest_base_count,
            guest_max_count:  room.guest_max_count,
            id:               room.id,            
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

    def self.search(query)
      # params = {
      #   query: {
      #     match: {
      #       title: query,
      #     },
      #   },
      # }

      self.__elasticsearch__.search(query)
    end
    
  end
end