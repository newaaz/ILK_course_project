require 'rails_helper'

feature 'Partner can create property', %q{
  In order to place ads of property
  As an authenticated Partner
  I'd like to be able to create Property
} do

  given(:partner)  { create(:partner) }
  given!(:town)    { create(:town) }
  given!(:category){ create(:category) }

  describe 'Authenticated partner' do
    background do
      sign_in_partner(partner)
      click_on 'Dashboard Partner'
      click_on 'New property'
    end

    scenario 'create property with attachment' do  
      fill_in 'property_title', with: "Hotel 'California'"
      fill_in 'property_address', with: 'Lenina 15'
      fill_in 'property_geolocation_attributes_latitude', with: '45.03248'
      fill_in 'property_geolocation_attributes_longitude', with: '35.20939'
      select town.name, from: "property_town_id"
      select category.title, from: "property_category_id"   
      attach_file 'property_avatar', "#{Rails.root}/spec/support/assets/placeholder10.jpg"
      attach_file 'property_images', ["#{Rails.root}/spec/support/assets/placeholder20.jpg",
                                      "#{Rails.root}/spec/support/assets/placeholder30.jpg"]

      click_on 'Save' 
      
      expect(page).to have_content 'Property successfully created'
      expect(page).to have_content "Hotel 'California'"
      within ".property-images" do
        expect(page).to have_css("img[alt='placeholder10.jpg']")
        expect(page).to have_css("img[alt='placeholder20.jpg']")
        expect(page).to have_css("img[alt='placeholder30.jpg']")
      end
    end
  
    scenario 'create property with errors' do
      click_on 'Save' 
      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated partner tries to create property' do
    visit properties_path
    click_on 'New property'

    expect(page).to have_content 'You are not authorized to perform this action.'
  end


end

