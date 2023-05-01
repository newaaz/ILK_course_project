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

    oauth_provider = OauthProvider.find_by(provider: auth.provider, uid: auth.uid.to_s)
    return oauth_provider.customer if oauth_provider
    
    if email = auth.info[:email]
      customer = Customer.find_by(email: email) || Customer.create!(email: email, password: Devise.friendly_token[0, 20], confirmed_at: Time.now)
      customer.oauth_providers.create(provider: auth.provider, uid: auth.uid)
      customer
    else
      Customer.new
    end    
  end
  
end
