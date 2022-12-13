require 'rails_helper'

feature 'User can sign up as Partner', %q{
  In order to place ads
  As an unregistered user
  I'd like to be able to sign up as Partner
} do

  #given(:partner)             { build(:partner) }
  given(:registered_partner)  { create(:partner) }

  scenario 'Unregistered partner tries to sign up' do
    complete_registration
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address'
  end

  scenario 'Unregistered partner tries to sign up with errors' do
    visit new_partner_registration_path
    click_on 'Sign up'

    expect(page).to have_content 'prohibited this partner from being saved:'
  end  

  scenario 'Registered partner tries to sign up' do
    visit new_partner_registration_path
    fill_in 'Email', with: registered_partner.email
    fill_in 'Password', with: registered_partner.password
    fill_in 'Password confirmation', with: registered_partner.password
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Authenticated partner tries to sign up' do
    sign_in_partner(registered_partner)
    visit new_partner_registration_path

    expect(page).to have_content 'You are already signed in.'
  end

  def complete_registration
    visit new_partner_registration_path
    fill_in 'Email', with: 'partner@mail.ru'
    fill_in 'Password', with: '340242'
    fill_in 'Password confirmation', with: '340242'
    click_on 'Sign up'
  end
end
