require 'rails_helper'

feature 'Partner can create rooms', %q{
  In order customer can choise room type
  As an authenticated Partner and owner property
  I'd like to be able to add room to property
} do

  given(:partner)  { create :partner }
  given!(:property) { create :property, owner: partner }

  describe 'Authencticated correct partner' do
    background do
      sign_in_partner(partner)
      visit partners_root_path
      within "#property_#{property.id}" do
        click_on 'Add room'
      end     
    end
    
    scenario 'add room to property' do
      fill_in 'room_title', with: "Standard"
      fill_in 'room_guest_base_count', with: 2
      fill_in 'room_guest_max_count', with: 4
      click_on 'Save'

      expect(page).to have_content 'Room was added'
    end

    scenario 'add room to property with errors'
  end








end
