require 'rails_helper'

feature 'The visitor can see the cost of booking a room for the entered date', %q{
  In order to see booking room cost
  As an any user
  I'd like to be able see cost of booking a room for the set date
} do

  # given(:town)         { create :town }
  # given(:town_feo)     { create :town, name: 'Feo' }
  # given(:cat_hotels)   { create :category, title: 'Hotels' }
  # given(:cat_flats)    { create :category, title: 'Flats' }
  # given!(:properties)  { create_list :property, 3, :imagable, :reindex, town: town, category: cat_hotels }
  # given(:feo_hotel)    { create :property, :imagable, :reindex, town: town_feo, category: cat_flats  }
  # given(:room)         { create :room, property: feo_hotel }
  # given!(:price)       { create :price, start_date: "2023-05-31", end_date: "2023-07-15", day_cost: 35, room: room }


  given(:property) { create :property, :imagable, :reindex }
  given(:room)     { create :room, :imagable, property: property }
  given!(:price)   { create :price, start_date: "2023-05-31", end_date: "2023-07-15", day_cost: 35, room: room }

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

    visit property_path property

    within '.booking-cost' do
      expect(page).to have_content "665"
    end 
  end

  # form for dates on property#show 


end
