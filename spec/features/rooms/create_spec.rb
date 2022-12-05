require 'rails_helper'

feature 'Partner can create rooms', %q{
  In order customer can choise room type
  As an authenticated Partner and owner property
  I'd like to be able to add room to property
} do

  given(:partner)   { create :partner }
  given(:non_owner) { create :partner }
  given!(:property) { create :property, owner: partner }

  describe 'Authencticated owner of property' do
    background do
      sign_in_partner(partner)
      click_on 'Dashboard Partner'
      within "#property_#{property.id}" do
        click_on 'Add room'
      end     
    end
    
    scenario 'add room to property with valid attributes' do
      fill_in 'room_title', with: "Standard 3-x"
      fill_in 'room_guest_base_count', with: 3
      fill_in 'room_guest_max_count', with: 5
      click_on 'Save'

      expect(page).to have_content 'Room was added'
      within "#property_#{property.id}" do
      expect(page).to have_content 'Standard 3-x'
      end 
    end

    scenario 'add room to property with valid attributes' do
      click_on 'Save'

      expect(page).to have_content "Errors:"
    end
  end

  scenario 'Authenticated non-owner of property tries add room' do
    sign_in_partner(non_owner)
    click_on 'Dashboard Partner'

    expect(page).to_not have_css("div#property_#{property.id}")
  end

  scenario 'Unauthenticated user tries add room' do
    visit root_path
    expect(page).to_not have_link 'Dashboard Partner'
  end
end
