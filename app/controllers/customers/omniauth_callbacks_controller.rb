# frozen_string_literal: true

class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  Devise.omniauth_configs.keys.each do |provider|
    define_method provider do
      @customer = Customer.find_for_oauth(request.env["omniauth.auth"])

      if @customer&.persisted?
        redirect_unconfirmed_customer unless @customer.confirmed?

        set_flash_message(:notice, :success, kind: "#{provider.capitalize}") if is_navigational_format?
        sign_in_and_redirect @customer, event: :authentication      
      else
        session[:oauth_provider] = request.env['omniauth.auth']['provider']
        session[:oauth_uid] = request.env['omniauth.auth']['uid']
  
        redirect_to customers_new_customer_path      
      end
    end
  end

  private

  def redirect_unconfirmed_customer
    flash[:alert] = 'You have to confirm your email address before continuing.'
    redirect_to new_customer_session_path
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
