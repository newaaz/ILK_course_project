module Contactable
  extend ActiveSupport::Concern

  included do
    has_one :contact, as: :contactable, dependent: :destroy
    accepts_nested_attributes_for :contact, reject_if: :contact_optional_and_blank?

    def contactless?
      contact.nil? && email.blank? && site.blank? && vk_group.blank?
    end

    private

    def contact_optional_and_blank?(attributes)
      ['Place', 'Cafe'].include?(self.model_name.name) && attributes[:name].blank? && attributes[:phone_number].blank?
    end
  end
end
