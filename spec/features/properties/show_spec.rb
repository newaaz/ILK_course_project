require 'rails_helper'

feature 'User can see property details', %q{
  In order to get detailed information about property
  As any user
  I'd like to be able to see property full info
} do

  given!(:property) { create :property, :imagable }

  scenario 'The visitor comes to the property page' do
    visit property_path property
    
    expect(page).to have_content "Hotel 'Alexandra'"
    expect(page).to have_content "Lenina 15"
    within ".property-images" do
      expect(page).to have_css("img"), count: 3  
    end  
  end
end
