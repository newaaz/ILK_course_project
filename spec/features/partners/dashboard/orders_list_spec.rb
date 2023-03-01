require 'rails_helper'

feature 'Partner can view orders list of their properties', %q{
  In order to check new orders
  As an authenticated Partner
  I'd like to be able see orders list of my properties
} do

  given(:customer) { create :customer }
  given(:owner)    { create :partner }
  given(:property) { create :property, owner: owner }
  given!(:orders)  { create_list :order, 3, property: property}

  scenario 'Authenticated partner' do
    sign_in_partner(owner)
    click_on 'Dashboard'
    within '.dashboard-menu-links' do
      click_on 'Orders'
    end

    expect(page).to have_content "Orders"
    orders.each do |order|
      expect(page).to have_content "№-#{order.id}"
    end
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
