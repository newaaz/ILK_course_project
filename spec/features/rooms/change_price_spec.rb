require 'rails_helper'

feature 'Owner can change price belongs his room when edit room', %q{
    In order to change price of date diapason
    As an owner of room
    I'd like to be able to change prices belongs to my room
} do

  given(:owner)    { create :partner }
  given(:property) { create :property, owner: owner }
  given(:room)     { create :room, :imagable, property: property }
  given!(:price)   { create :price, room: room }

  before { sign_in_partner(owner) }

  scenario 'Owner delete price when edit room', js: true do    
    click_on 'Dashboard Partner'
    within "#property_#{property.id}" do
      within "#room_#{room.id}" do
        click_on 'Edit'
      end
    end

    within "#price_#{price.id}" do      
      fill_in with: '05.01.2022', placeholder: 'start-date'
      fill_in with: '06.02.2022', placeholder: 'end-date'
      fill_in with: 999,          placeholder: 'day-cost'
    end

    click_on 'Save'

    expect(page).to have_css("#price_#{price.id}")
    expect(page).to_not have_content price.day_cost  
    expect(page).to have_content "from: 01.05 to: 02.06 - 999"
  end
end
