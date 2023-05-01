class FindForOauthService
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    oauth_provider = OauthProvider.find_by(provider: auth.provider, uid: auth.uid.to_s)
    return oauth_provider.customer if oauth_provider
    
    if email = auth.info[:email]
      find_or_create_customer_by_email(email)
    else
      Customer.new
    end
  end

  private

  def find_or_create_customer_by_email(email)
    customer = Customer.find_by(email: email) || Customer.create!(email: email, password: Devise.friendly_token[0, 20], confirmed_at: Time.now)
    customer.oauth_providers.create(provider: auth.provider, uid: auth.uid)
    customer
  end
end
