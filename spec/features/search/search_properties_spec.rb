require 'rails_helper'

feature 'The user can search properties by filters and price range', %q{
  In order to find a suitable property
  As an visitor
  I'd like to be able set price range, available amenities and number of adults and child when looking for a property
} do

  given(:town)        { create :town }
  given(:properties)  { create_list :property, 3, :imagable, town: town }

  scenario 'search property' do    
    visit root_path
    within "#search-form" do
      select "Koktebel", from: "town_id"
      fill_in 'check_in', with: '05.01.2022'
      fill_in 'check_out', with: '05.02.2022'
      fill_in 'adults', with: '2'
      fill_in 'child', with: '1'
      click_on 'Search'
    end  

    expect(page).to have_content "Finded 2 property"
  end


end


