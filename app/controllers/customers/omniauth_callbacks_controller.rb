# frozen_string_literal: true

class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    @customer = Customer.find_for_oauth(request.env["omniauth.auth"])
    if @customer&.persisted?
      sign_in_and_redirect @customer, event: :authentication #this will throw if @customer is not activated
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      redirect_to root_path, alert: "Something went wrong"
    end
  end

  private

  def sign_in_with_provider
    @customer = Customer.find_for_oauth(request.env["omniauth.auth"])

    if @customer&.persisted?
      redirect_unconfirmed_customer unless @customer.confirmed?

      sign_in_and_redirect @customer, event: :authentication
      set_flash_message(:notice, :success, kind: "#{action_name.capitalize}") if is_navigational_format?
    else
      session[:oauth_provider] = request.env['omniauth.auth']['provider']
      session[:oauth_uid] = request.env['omniauth.auth']['uid']
 
      redirect_to new_customer_registration_path      
    end
  end

  def redirect_unconfirmed_user
    flash[:alert] = 'You have to confirm your email address before continuing.'
    redirect_to new_customer_session_path
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
