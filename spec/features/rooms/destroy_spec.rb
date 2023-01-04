require 'rails_helper'

feature 'Only owner can delete room of his property', %q{
  In order to other partners can't delete some one else properties room
  As an authenticated partner and owner of the property
  I'd like to be able to delete room of my property
} do

  given(:owner)     { create :partner }
  given(:non_owner) { create :partner }
  given(:property)  { create :property, owner: owner }
  given!(:room)     { create :room, :imagable, property: property }

  scenario 'Authenticated owner of room property deletes room' do
    sign_in_partner(owner)
    click_on 'Dashboard Partner'
    within "#property_#{property.id}" do
      within "#room_#{room.id}" do
        click_on 'Delete'
      end
    end     
  
    expect(page).to have_content "Room was destroyed"
    expect(page).to_not have_css("#property_#{room.id}")
  end

  scenario 'Authenticated non-owner of property tries to destroy some one else property' do
    sign_in_partner(non_owner)
    click_on 'Dashboard Partner'
    expect(page).to_not have_css("#property_#{room.id}")
  end

  scenario 'Unauthenticated partner tries to destroy property' do
    visit root_path
    expect(page).to_not have_link('Dashboard Partner')
  end
end

