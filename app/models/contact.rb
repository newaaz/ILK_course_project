class Contact < ApplicationRecord
  MESSENGERS = %i[whatsapp viber telegram]

  MESSENGERS_URLS = {
    whatsapp: {
                url_start: "https://wa.me/",
                url_end: "?text=Здравствуйте! Мы нашли Ваш объект на сайте Люблю Крым",
                color: "success",
                icon: "whatsapp"
              },
    viber:    {
                url_start: "viber://chat?number=",
                url_end: "",
                color: "purple",
                icon: "telephone"
              },
    telegram: {
                url_start: "https://t.me/+",
                url_end: "",
                color: "primary",
                icon: "telegram"
              },
  }

  mount_uploader  :avatar, PictureUploader

  belongs_to :contactable, polymorphic: true

  # validates :name, presence: true
end
