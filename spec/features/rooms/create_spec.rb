require 'rails_helper'

feature 'Partner can create rooms', %q{
  In order customer can choise room type
  As an authenticated Partner and owner property
  I'd like to be able to add room to property
} do

  given(:partner)   { create :partner }
  given(:non_owner) { create :partner }
  given!(:property) { create :property, owner: partner }

  describe 'Authencticated owner of property create with avatar+images' do
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
      attach_file 'room_avatar', "#{Rails.root}/spec/support/placeholders/placeholder10.jpg"
      attach_file 'room_images', ["#{Rails.root}/spec/support/placeholders/placeholder20.jpg", "#{Rails.root}/spec/support/placeholders/placeholder30.jpg"]

      click_on 'Save'

      expect(page).to have_content 'Room was added'
      within "#property_#{property.id}" do
        expect(page).to have_content 'Standard 3-x'
        expect(page).to have_css("img[alt='placeholder10.jpg']")
        expect(page).to have_css("img[alt='placeholder20.jpg']")
        expect(page).to have_css("img[alt='placeholder30.jpg']")
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
