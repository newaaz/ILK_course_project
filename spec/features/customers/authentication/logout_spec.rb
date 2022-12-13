require 'rails_helper'

feature 'Customer can logout', %q{
  In order to logout from system
  As an authenticated customer
  I'd like to be able to logout
} do

  given(:customer) { create(:customer) }

  scenario 'Authenticated customer tries logout' do
    sign_in_customer(customer)
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unauthenticated user tries log out' do
    visit root_path
    expect(page).to_not have_content 'Logout'      
  end
end
