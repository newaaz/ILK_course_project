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
      visit properties_path
      click_on 'New property'
    end

    scenario 'create property' do  
      fill_in 'property_title', with: "Hotel 'California'"
      fill_in 'property_address', with: 'Lenina 15'
      select town.name, from: "property_town_id"
      select category.title, from: "property_category_id"
      click_on 'Save' 
      
      expect(page).to have_content 'Property successfull created'
      expect(page).to have_content "Hotel 'California'"
    end
  
    scenario 'create property with errors' do
      click_on 'Save' 
      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated partner tries to create property' do
    visit properties_path
    click_on 'New property'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end


end

