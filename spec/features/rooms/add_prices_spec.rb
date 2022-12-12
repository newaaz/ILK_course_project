require 'rails_helper'

feature 'Partner can add prices to rooms', %q{
  In order customer can see total cost for selected time period
  As an authenticated Partner and owner property
  I'd like to be able to add prices for time period to room
} do

  given(:partner)   { create :partner }
  given!(:property) { create :property, owner: partner }

  background { sign_in_partner(partner) }

  describe 'Partner owner add prices when create room', js: true do
    background do
      click_on 'Dashboard Partner'
      within "#property_#{property.id}" do
        click_on 'Add room'
      end
      fill_in 'room_title', with: "Standard 3-x"
      attach_file 'room_avatar', "#{Rails.root}/spec/support/assets/placeholder10.jpg"
    end

    scenario 'with valid attributes' do
      click_on 'remove price'    
      3.times { click_on 'add price' }

      page.all('.nested-fields').each do |field|
        within(field) do
          fill_in with: '05.01.2022', placeholder: 'start-date'
          fill_in with: '06.02.2022', placeholder: 'end-date'
          fill_in with: 999,          placeholder: 'day-cost'
        end
      end    

      click_on 'Save' 

      expect(page).to have_content 'Room was added'
      expect(page).to have_content "from: 01.05 to: 02.06 - 999", count: 3
    end

    scenario 'with invalid attributes' do      
      within '.nested-fields' do
        fill_in with: '2022/11/01', placeholder: 'start-date'
        fill_in with: '2022/12/01', placeholder: 'end-date'
        fill_in with: nil,          placeholder: 'day-cost'
      end
    
      click_on 'Save' 
  
      expect(page).to have_content "Prices day cost can't be blank"
    end
  end
end
