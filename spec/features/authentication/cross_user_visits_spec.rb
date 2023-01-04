require 'rails_helper'

feature "Authenticated Partner/Customer can't signup or signin as Customer/Partner", %q{
  In order to fix cross model visits
  As an unregistered user
  I'd like to not be able to signup/signin as Partner when Customer and vice versa
} do

  given(:partner)  { create(:partner) }
  given(:customer) { create(:customer) }

  describe 'Authenticated partner' do
    background { sign_in_partner(partner) }

    scenario 'signup as customer' do
      visit new_customer_registration_path
      expect(page).to have_content 'You are partner (from Acessibled)'
    end

    scenario 'signin as customer' do
      visit new_customer_session_path
      expect(page).to have_content 'You are partner (from Acessibled)'
    end  
  end

  describe 'Authenticated customer' do
    background { sign_in_customer(customer) }

    scenario 'signup as partner' do
      visit new_partner_registration_path
      expect(page).to have_content 'You are customer (from Acessibled)'
    end

    scenario 'signin as partner' do
      visit new_partner_session_path
      expect(page).to have_content 'You are customer (from Acessibled)'
    end  
  end
end
