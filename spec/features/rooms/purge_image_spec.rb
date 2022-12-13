require 'rails_helper'

feature 'Owner can purge room images', %q{
    In order to change room images
    As an owner of properties room
    I'd like to be able to purge room images when edit
} do

  given(:owner)     { create :partner }
  given(:property)  { create :property, :imagable, owner: owner }
  given(:room)      { create :room, :imagable, property: property } 
  given!(:image_id) { room.images.first.id }

  before { sign_in_partner(owner) }

  scenario 'Owner purge images when edit room' do    
    click_on 'Dashboard Partner'
    within "#property_#{property.id}" do
      within "#room_#{room.id}" do
        click_on 'Edit'
      end
    end

    within "#attachment_#{image_id}" do      
      click_on 'delete'
    end

    expect(page).to_not have_css("#attachment_#{image_id}")    
    expect(page).to have_content "image deleted"
  end
end
