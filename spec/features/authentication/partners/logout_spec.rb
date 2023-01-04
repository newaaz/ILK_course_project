require 'rails_helper'

feature 'Partner can logout', %q{
  In order to logout from system
  As an authenticated partner
  I'd like to be able to logout
} do

  given(:partner) { create(:partner) }

  scenario 'Authenticated partner tries logout' do
    sign_in_partner(partner)
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unauthenticated user tries log out' do
    visit root_path
    expect(page).to_not have_content 'Logout'      
  end
end
