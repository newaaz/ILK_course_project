require 'rails_helper'

feature 'Owner can delete prices belongs his room when edit room', %q{
    In order to correct mistakes
    As an owner of room
    I'd like to be able to delete prices belongs to my room
} do

  given(:owner)    { create :partner }
  given(:property) { create :property, :imagable, owner: owner }
  given(:room)     { create :room, :imagable, property: property }
  given!(:price)   { create :price, room: room }

  before { sign_in_partner(owner) }

  scenario 'Owner delete price when edit room', js: true do    
    visit partners_root_path
    within "#property_#{property.id}" do
      within "#room_#{room.id}" do
        click_on 'Edit'
      end
    end

    find("#price_#{price.id}").click_on 'remove price'

    click_on 'Save'

    expect(page).to_not have_css("#price_#{price.id}")
    expect(page).to_not have_content price.day_cost  
  end
end
