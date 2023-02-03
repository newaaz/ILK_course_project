require 'rails_helper'

feature 'The user can search properties by towns, categories, number of guests and date available', %q{
  In order to find a suitable property
  As an visitor
  I'd like to be able set date check-in/check-out, category of properties, towns,
  number of guests when looking for a property
} do

  given(:town)         { create :town }
  given(:town_feo)     { create :town, name: 'Feo' }
  given(:category)     { create :category }
  given(:cat_flats)    { create :category, title: 'Flats' }
  given!(:properties)  { create_list :property, 3, :imagable, :reindex, town: town }
  given(:feo_hotel)    { create :property, :imagable, :reindex, town: town_feo, category: cat_flats  }
  given(:room)         { create :room, property: feo_hotel }
  given!(:price)       { create :price, start_date: "2023-05-31", end_date: "2023-07-15", day_cost: 35, room: room }

  before do
    Property.reindex
    visit root_path
  end

  scenario 'search all property', js: true do 
    within "#search-form" do
      click_on 'Search'
    end  
    expect(page).to have_content "Found 4 property"    
  end

  scenario 'search by town', js: true do 
    within "#search-form" do
      select "Feo", from: "town_id"
      click_on 'Search'
    end  
    expect(page).to have_content "Found 1 property"    
  end

  scenario 'search by category', js: true do 
    within "#search-form" do
      select "Flats", from: "category_id"
      click_on 'Search'
    end  
    expect(page).to have_content "Found 1 property"    
  end

  scenario 'search by number of guests', js: true do    
    within "#search-form" do
      fill_in 'guests', with: 2
      click_on 'Search'
    end
    expect(page).to have_content "Found 1 property"    
  end

  scenario 'search by arrival dates', js: true do    
    within "#search-form" do      
      fill_in 'check_in', with: '14.06.2023'
      fill_in 'check_out', with: '03.07.2023'
      click_on 'Search'
    end  
    expect(page).to have_content "Found 1 property"    
  end
end
