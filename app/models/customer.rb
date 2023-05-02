class Customer < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :confirmable,
          :omniauthable, omniauth_providers: %i[github vkontakte]

  has_many  :orders, dependent: :destroy
  has_many  :oauth_providers, dependent: :destroy

  def self.find_for_oauth(auth)
    FindForOauthService.new(auth).call
  end
end
