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

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
