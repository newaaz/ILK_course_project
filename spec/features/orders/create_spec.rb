require 'rails_helper'

feature 'Customer can book room in property ', %q{
  In order to booking property
  As an authenticated Customer
  I'd like to be able create order
} do

  given(:customer)  { create :customer }
  given(:partner)   { create :partner }
  given(:property)  { create :property, :imagable }
  given!(:room)     { create :room, :imagable, property: property }

  describe 'Authenticated customer bookes property' do
    background do
      sign_in_customer(customer)
      visit property_path(property)
      within "#room_#{room.id}" do
        click_on 'Book'
      end
    end

    scenario 'with valid attributes' do
      select room.title, from: "order_room_id"
      fill_in 'order_check_in', with: '05.01.2022'
      fill_in 'order_check_out', with: '05.02.2022'
      fill_in 'order_adults', with: '2'
      fill_in 'order_kids', with: '0'
      click_on 'Send'

      expect(page).to have_content "Order №-#{Order.last.id} to #{property.title} in #{room.title} created"
    end
    
    scenario 'with invalid attributes' do
      click_on 'Send'

      expect(page).to have_content "Check in can't be blank"
      expect(page).to have_content "Check out can't be blank"
    end  
  end

  scenario 'Unauthenticated user bookes property' do    
    visit property_path(property)
    within "#room_#{room.id}" do
      click_on 'Book'
    end  

    expect(page).to have_content "You are not authorized to perform this action."
  end

  scenario 'Authenticated partner bookes property' do
    sign_in_partner(partner)
    visit property_path(property)
    within "#room_#{room.id}" do
      click_on 'Book'
    end  

    expect(page).to have_content "You are not authorized to perform this action."
  end
end
