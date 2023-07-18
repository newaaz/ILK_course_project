module ListingActivatable
  extend ActiveSupport::Concern
  included do  
    after_create :send_listing_creating_email

    scope :activated, -> { where(activated: true) }

    def activate!
      unless self.activated?
        self.toggle!(:activated)
        ListingMailer.listing_activated(self).deliver_now
      end
    end

    private

    def send_listing_creating_email
      ListingMailer.listing_created(self).deliver_now unless self.activated?
    end  
  end  
end
