module AdditionalFieldable
  extend ActiveSupport::Concern

  included do
    has_many :additional_fields, as: :additional_fieldable, dependent: :destroy
    accepts_nested_attributes_for :additional_fields, allow_destroy: true, reject_if: :all_blank
  end
end
