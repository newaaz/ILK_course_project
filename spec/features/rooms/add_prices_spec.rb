require 'rails_helper'

feature 'Partner can add prices to rooms', %q{
  In order customer can see total cost for selected time period
  As an authenticated Partner and owner property
  I'd like to be able to add prices for time period to room
} do

  given(:partner)   { create :partner }
  given!(:property) { create :property, :imagable, owner: partner }

  background { sign_in_partner(partner) }

  describe 'Partner owner add prices when create room', js: true do
    background do
      visit partners_root_path
      within "#property_#{property.id}" do
        click_on 'Add room'
      end
      fill_in 'room_title', with: "Standard 3-x"
      attach_file 'room_avatar', "#{Rails.root}/spec/support/assets/placeholder10.jpg"
    end

    scenario 'with valid attributes' do
      within '.nested-fields' do
        fill_in with: '06/15/2023', placeholder: 'start-date'
        fill_in with: '06/24/2023', placeholder: 'end-date'
        fill_in with: 90,          placeholder: 'day-cost'
      end

      click_on 'Save' 

      expect(page).to have_content 'Room was added'
      expect(page).to have_content "from: 15.06 to: 24.06 - 90", count: 1
    end

    scenario 'with invalid attributes' do      
      within '.nested-fields' do
        fill_in with: '06/15/2023', placeholder: 'start-date'
        fill_in with: '06/24/2023', placeholder: 'end-date'
        fill_in with: nil,          placeholder: 'day-cost'
      end
    
      click_on 'Save' 
  
      expect(page).to have_content "Prices day cost can't be blank"
    end

    scenario 'with start_date older end_date' do      
      within '.nested-fields' do
        fill_in with: '06/24/2023', placeholder: 'start-date'
        fill_in with: '06/15/2023', placeholder: 'end-date'
        fill_in with: 45,          placeholder: 'day-cost'
      end
    
      click_on 'Save' 
  
      expect(page).to have_content "Prices start date should be earlier end date"
    end

    scenario 'with intersect date ranges' do
      click_on 'add price'
      
      page.all('.nested-fields').each do |field|
        within(field) do
          fill_in with: '06/15/2023', placeholder: 'start-date'
          fill_in with: '06/24/2023', placeholder: 'end-date'
          fill_in with: 90,          placeholder: 'day-cost'
        end
      end

      click_on 'Save' 

      expect(page).to have_content "Prices - there are intersect date ranges in prices"
    end
  end
end
