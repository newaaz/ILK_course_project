require 'rails_helper'

feature 'Owner can purge property images', %q{
    In order to change property images
    As an owner of property
    I'd like to be able to purge property images when edit
} do

  given(:owner)     { create :partner }
  given(:property)  { create :property, :imagable, owner: owner }
  given!(:image_id) { property.images.first.id }

  before { sign_in_partner(owner) }

  scenario 'Owner purge images when edit room' do    
    click_on 'Dashboard Partner'
    within "#property_#{property.id}" do
      click_on 'Edit'
    end

    within "#attachment_#{image_id}" do      
      click_on 'delete'
    end

    expect(page).to_not have_css("#attachment_#{image_id}")    
    expect(page).to have_content "image deleted"
  end
end
