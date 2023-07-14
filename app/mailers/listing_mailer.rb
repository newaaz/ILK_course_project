class ListingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.listing_mailer.listing_created.subject
  #
  def listing_created(listing)
    @listing = listing

    mail to: Rails.application.credentials.email[:login], subject: "New listing created"
  end

  def listing_activated(listing)
    @listing = listing
    
    mail to: @listing.owner.email, subject: "Люблю Крым: Ваше объявление активировано и опубликовано"
  end

  def booking_created(booking)
    @booking = booking

    mail to: @booking.property.owner.email, subject: "Люблю Крым: Новая заявка"
  end
end
