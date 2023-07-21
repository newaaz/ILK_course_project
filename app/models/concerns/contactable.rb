module Contactable
  extend ActiveSupport::Concern

  included do
    has_one :contact, as: :contactable, dependent: :destroy
    accepts_nested_attributes_for :contact
  end
end
