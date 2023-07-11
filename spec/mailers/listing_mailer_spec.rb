require "rails_helper"

RSpec.describe ListingMailer, type: :mailer do
  describe "listing_created" do
    let(:mail) { ListingMailer.listing_created }

    it "renders the headers" do
      expect(mail.subject).to eq("Listing created")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
