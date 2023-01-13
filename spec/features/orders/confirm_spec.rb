require 'rails_helper'

feature 'The partner-owner can confirm order', %q{
  In order to confirm arrival dates are available
  As an owner of property
  I'd like to be able confirm order
} do

  given(:customer)  { create :customer }
  given(:partner)   { create :partner }
  given(:property)  { create :property, :imagable, owner: partner }
  given(:room)      { create :room, :imagable, property: property }
  given!(:price)    { create :price, start_date: '2023-05-31', end_date: '2023-09-16', day_cost: 35, room: room }
  given(:order)     { build :order, check_in: price.start_date + 1, check_out: price.start_date + 10, customer: customer, property: property, room: room }

  background do
    order.save(validate: false)
    sign_in_partner(partner)
    click_on 'Dashboard Partner'
    click_on 'Orders'
  end

  scenario 'Owner confirm order' do  
    within "#row_order_#{order.id}" do
      click_on 'Accept'
      expect(page).to have_content "accepted"
    end
  end
end
