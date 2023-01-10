require 'rails_helper'

feature 'Customer can book room in property ', %q{
  In order to booking property
  As an authenticated Customer
  I'd like to be able create order
} do

  given(:customer)  { create :customer }
  given(:partner)   { create :partner }
  given(:property)  { create :property, :imagable }
  given(:room)      { create :room, :imagable, property: property }
  given!(:price_1)  { create :price, start_date: "2023-05-31", end_date: "2023-06-16", day_cost: 35, room: room }
  given!(:price_2)  { create :price, start_date: "2023-06-17", end_date: "2023-06-30", day_cost: 45, room: room }
  given!(:price_3)  { create :price, start_date: "2023-07-01", end_date: "2023-07-15", day_cost: 60, room: room }
  

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
      fill_in 'order_check_in', with: '14.06.2023'
      fill_in 'order_check_out', with: '03.07.2023'
      fill_in 'order_adults', with: '2'
      fill_in 'order_kids', with: '0'
      click_on 'Send'
    
      expect(page).to have_content "Order №-#{Order.last.id} to #{property.title} in #{room.title} created. Total: 915"
    end
    
    scenario 'with invalid attributes' do
      click_on 'Send'

      expect(page).to have_content "Check in can't be blank"
      expect(page).to have_content "Check out can't be blank"
    end

    scenario 'with check out earlier check in' do
      select room.title, from: "order_room_id"
      fill_in 'order_check_in', with: '03.07.2023'
      fill_in 'order_check_out', with: '14.06.2023'
      fill_in 'order_adults', with: '2'
      fill_in 'order_kids', with: '0'
      click_on 'Send'
    
      expect(page).to have_content "Check in should be earlier check out"
    end

    scenario 'Arrival dates not in price_date ranges' do
      select room.title, from: "order_room_id"
      fill_in 'order_check_in', with: '14.06.2023'
      fill_in 'order_check_out', with: '03.12.2023'
      fill_in 'order_adults', with: '2'
      fill_in 'order_kids', with: '0'
      click_on 'Send'
    
      expect(page).to have_content "Date range - availability is limited"
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
