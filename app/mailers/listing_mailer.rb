class ListingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.listing_mailer.listing_created.subject
  #
  def listing_created(listing)
    @listing = listing

    mail to: Rails.application.credentials.email[:login],
         subject: "New listing created"
  end
end
