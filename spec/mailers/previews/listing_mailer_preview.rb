# Preview all emails at http://localhost:3000/rails/mailers/listing_mailer
class ListingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/listing_mailer/listing_created
  def listing_created
    ListingMailer.listing_created(Property.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/listing_mailer/listing_activated
  def listing_activated
    ListingMailer.listing_activated(Property.last)
  end

  # http://localhost:3000/rails/mailers/listing_mailer/booking_created
  def booking_created
    ListingMailer.booking_created(Booking.last)
  end

end
