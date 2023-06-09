class Contact < ApplicationRecord
  MESSENGERS = %i[whatsapp viber telegram]

  belongs_to :contactable, polymorphic: true
end
