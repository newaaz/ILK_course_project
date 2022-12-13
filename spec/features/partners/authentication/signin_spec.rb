require 'rails_helper'

feature 'Partner can sign in', %q{
  In order to place ads
  As an registered Partner
  I'd like to be able to sign in as Partner
} do

  given(:partner) { create(:partner) }

  background { visit new_partner_session_path }

  scenario 'Registered Partner tries to sign in' do
    fill_in 'Email', with: partner.email
    fill_in 'Password', with: partner.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Unregistered Partner tries to sign up' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: 'wrong'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end
end

