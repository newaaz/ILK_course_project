module Ratingable
  extend ActiveSupport::Concern

  included do
    default_scope { order(rating: :desc) }
  end
end

