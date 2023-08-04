module Favoritable
  extend ActiveSupport::Concern

  included do
    has_many :favorite_items, as: :listing, dependent: :destroy
  end
end