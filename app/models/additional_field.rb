class AdditionalField < ApplicationRecord
  belongs_to :additional_fieldable, polymorphic: true
end
