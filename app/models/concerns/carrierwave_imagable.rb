module CarierwaveImagable
  extend ActiveSupport::Concern

  included do
    mount_uploader  :avatar, ListingUploader
    mount_uploaders :images, ListingUploader


  end
end
