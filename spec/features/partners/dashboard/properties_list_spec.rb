require 'rails_helper'

feature 'Partner can view their properties', %q{
  In order to check my properties
  As an authenticated Partner
  I'd like to be able view my properties list
} do

  given(:customer)    { create :customer }
  given(:owner)       { create :partner }
  given!(:properties) { create_list :property, 3, owner: owner }

  scenario 'Authenticated partner' do
    sign_in_partner(owner)
    click_on 'Dashboard'

    expect(page).to have_content "Hotel 'Alexandra'", count: 3
  end

  scenario 'Unauthenticated user' do
    visit root_path
    expect(page).to_not have_link('Dashboard')
  end

  scenario 'Authenticated customer' do
    sign_in_customer(customer)
    visit root_path
    expect(page).to_not have_css('.nav-partner')
  end
end
