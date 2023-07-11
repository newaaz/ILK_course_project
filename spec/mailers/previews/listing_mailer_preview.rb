# Preview all emails at http://localhost:3000/rails/mailers/listing_mailer
class ListingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/listing_mailer/listing_created
  def listing_created
    ListingMailer.listing_created(Property.last)
  end

end
