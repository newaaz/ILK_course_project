require 'rails_helper'

feature 'Customer can sign in', %q{
  In order to book properties
  As an registered customer
  I'd like to be able to sign in as customer
} do

  given(:customer) { create(:customer) }

  background { visit new_customer_session_path }

  scenario 'Registered customer tries to sign in' do
    fill_in 'Email', with: customer.email
    fill_in 'Password', with: customer.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Unregistered customer tries to sign up' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: 'wrong'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end
end

