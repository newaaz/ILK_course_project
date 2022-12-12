require 'rails_helper'

feature 'Partner can edit room of his property', %q{
    In order to change info about room
    As an owner of property
    I'd like to be able to edit room of my property
} do

  given(:partner)   { create :partner }
  given(:non_owner) { create :partner }
  given(:property)  { create :property, :imagable, owner: partner }
  given!(:room)     { create :room, :imagable, property: property }

  describe 'Authenticated partner - owner of property' do
    background do
      sign_in_partner(partner)
      click_on 'Dashboard Partner'
      within "#room_#{room.id}" do
        click_on 'Edit'
      end     
    end

    scenario 'edit his property with valid attributes' do
      fill_in 'room_title', with: "Serova street (Edited)"
      click_on 'Save'

      expect(page).to have_content "Room successfully updated"
      expect(page).to have_content "Serova street (Edited)"
    end

    scenario 'edit his property with invalid attributes' do
      fill_in 'room_title', with: ''
      click_on 'Save'
      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Authenticated non-owner of property tries to edit some one else property' do
    sign_in_partner(non_owner)
    click_on 'Dashboard Partner'
    expect(page).to_not have_css("#room_#{room.id}")
  end

  scenario 'Unauthenticated partner tries edit property' do
    visit root_path
    expect(page).to_not have_link('Dashboard Partner')
  end
end
