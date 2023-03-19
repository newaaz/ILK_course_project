require 'rails_helper'

feature 'The visitor can see the cost of booking a room for the entered date', %q{
  In order to see booking room cost
  As an any user
  I'd like to be able see cost of booking a room for the set date
} do

  given(:property) { create :property, :imagable, :reindex }
  given(:room)     { create :room, :imagable, property: property }
  given!(:price)   { create :price, start_date: "2023-05-31", end_date: "2023-11-15", day_cost: 35, room: room }

  before do
    Property.reindex
    visit root_path
  end

  #  FIXME: Don't work due dates LitePicker
  scenario 'search by arrival dates', js: true do    
    within "#search-form" do      
      fill_in 'check_in', with: '14.06.2023'
      fill_in 'check_out', with: '03.07.2023'
      click_on 'Search'
    end

    #page.set_rack_session(check_in: '14.06.2023')
    #page.set_rack_session(check_in: '03.07.2023')

    visit property_path property

    within '.booking-cost' do
      expect(page).to have_content "665"
    end 
  end

  # form for dates on property#show 

end
