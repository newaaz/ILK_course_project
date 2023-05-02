class OauthProvider < ApplicationRecord
  belongs_to :customer

  validates :provider, :uid, presence: true
  validates :provider, uniqueness: { scope: :uid, message: "Provider already exists for this uid." }
end
