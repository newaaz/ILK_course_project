require 'rails_helper'

feature 'User can sign up as Customer', %q{
  In order to place ads
  As an unregistered user
  I'd like to be able to sign up as Customer
} do

  given(:registered_customer)  { create(:customer) }

  scenario 'Unregistered customer tries to sign up' do
    complete_registration
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address'
  end

  scenario 'Unregistered customer tries to sign up with errors' do
    visit new_customer_registration_path
    click_on 'Sign up'

    expect(page).to have_content 'prohibited this customer from being saved:'
  end  

  scenario 'Registered customer tries to sign up' do
    visit new_customer_registration_path
    fill_in 'Email', with: registered_customer.email
    fill_in 'Password', with: registered_customer.password
    fill_in 'Password confirmation', with: registered_customer.password
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Authenticated customer tries to sign up' do
    sign_in_customer(registered_customer)
    visit new_customer_registration_path

    expect(page).to have_content 'You are already signed in.'
  end

  def complete_registration
    visit new_customer_registration_path
    fill_in 'Email', with: 'customer@mail.ru'
    fill_in 'Password', with: '340242'
    fill_in 'Password confirmation', with: '340242'
    click_on 'Sign up'
  end
end





