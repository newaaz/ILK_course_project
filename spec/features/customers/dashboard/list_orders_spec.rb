require 'rails_helper'

feature 'Customer can view their orders', %q{
  In order to check my orders
  As an authenticated Customer
  I'd like to be able see list of my orders
} do

  given(:customer)  { create :customer }
  given(:partner)   { create :partner }
  given(:property)  { create :property, :imagable }
  given!(:room)     { create :room, :imagable, property: property }
  given!(:orders)   { create_list :order, 3, customer: customer }

  scenario 'Authenticated customer' do
    sign_in_customer(customer)

    visit property_path(property)

    within "#room_#{room.id}" do
      click_on 'Book'
    end

    select room.title, from: "order_room_id"
    fill_in 'order_check_in', with: '05.01.2022'
    fill_in 'order_check_out', with: '05.02.2022'
    fill_in 'order_adults', with: '9'
    fill_in 'order_kids', with: '5'
    click_on 'Send'

    click_on 'Dashboard Customer'

    orders.each do |order|
      expect(page).to have_content "Order №-#{order.id} to #{order.property.title} in #{order.room.title}"
      expect(page).to have_content "From: #{order.check_in.strftime('%d.%m.%y')} to: #{order.check_out.strftime('%d.%m.%y')}"
    end

    last_order = Order.last
    expect(page).to have_content "Order №-#{last_order.id} to #{property.title} in #{room.title}"
    expect(page).to have_content "From: 05.01.22 to: 05.02.22"
  end

  scenario 'Unauthenticated user' do
    visit root_path
    expect(page).to_not have_link('Dashboard Customer')
  end

  scenario 'Authenticated partner' do
    sign_in_partner(partner)
    visit root_path
    expect(page).to_not have_link('Dashboard Customer')
  end
end
