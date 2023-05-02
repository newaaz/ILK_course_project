class Customers::CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    password = Devise.friendly_token.first(8)
    @customer = Customer.new(email: params[:customer][:email], password: password, password_confirmation: password)

    if @customer.save
      send_confirm_email_for(@customer)
    else
      render :new
    end
  end

  private

  def send_confirm_email_for(customer)
    customer.oauth_providers.create(provider: session[:oauth_provider], uid:  session[:oauth_uid])

    session.delete %i[oauth_provider oauth_uid]

    customer.send_confirmation_instructions
    flash[:alert] = 'You will receive an email with instructions for how to confirm your email address in a few minutes.'
    redirect_to root_path
  end
end

