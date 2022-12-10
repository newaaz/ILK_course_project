require 'rails_helper'

feature 'Only owner can delete his property', %q{
  In order to other partners can't delete some one else properties
  As an authenticated partner and owner of the property
  I'd like to be able to delete my property
} do

  given(:partner)   { create :partner }
  given(:non_owner) { create :partner }
  given!(:property) { create :property, owner: partner }

  scenario 'Authenticated owner of property deletes his property' do
    sign_in_partner(partner)
    click_on 'Dashboard Partner'
    within "#property_#{property.id}" do
      click_on 'Delete'
    end     
  
    expect(page).to have_content "Property was destroyed"
    expect(page).to_not have_css("#property_#{property.id}")
  end

  scenario 'Authenticated non-owner of property tries to destroy some one else property' do
    sign_in_partner(non_owner)
    click_on 'Dashboard Partner'
    expect(page).to_not have_css("#property_#{property.id}")
  end

  scenario 'Unauthenticated partner tries to destroy property' do
    visit root_path
    expect(page).to_not have_link('Dashboard Partner')
  end
end
