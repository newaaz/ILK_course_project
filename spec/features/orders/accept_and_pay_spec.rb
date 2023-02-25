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
  given(:order)     { build  :order, check_in: price.start_date + 1, check_out: price.start_date + 10,
                                     customer: customer, property: property, room: room }

  background { order.save(validate: false) }

  scenario 'Accepting and paying, multiple_sessions' do
    Capybara.using_session('partner') do
      sign_in_partner(partner)
      click_on 'Dashboard'
      within '.dashboard-menu-links' do
        click_on 'Orders'
      end

      within "#row_order_#{order.id}" do
        click_on 'Accept'

        expect(page).to have_content "accepted"
        expect(page).to have_content "Waiting for payment"
        expect(page).to_not have_link 'Accept'
        expect(page).to_not have_link 'Reject'
      end
    end

    Capybara.using_session('customer') do
      sign_in_customer(customer)
      click_on 'Dashboard'
      within "#row_order_#{order.id}" do
        click_on "Pay #{order.total_amount}"

        expect(page).to have_content "paid"
        expect(page).to have_content "Paid #{order.total_amount}"
        expect(page).to_not have_link "Pay #{order.total_amount}"
      end
    end

    Capybara.using_session('partner') do
      Capybara.refresh
      within "#row_order_#{order.id}" do        
        expect(page).to have_content "paid"
        expect(page).to have_content "Paid #{order.total_amount}"
      end
    end
  end  
end
