require 'rails_helper'

feature 'Partner can create property', %q{
  In order to place ads of property
  As an authenticated Partner
  I'd like to be able to create Property
} do

  given(:partner) { Partner.create!(email: 'partner@test.com', password: '12345678') }

  scenario 'Authenticated partner create property' do
    visit new_partner_session_path
    fill_in 'Email', with: partner.email
    fill_in 'Password', with: partner.password
    click_on 'Log in'

    visit properties_path
    click_on 'Create property'

    fill_in 'title', with: "Hotel 'California'"
    fill_in 'address', with: 'Lenina 15'
    fill_in 'town_id', with: 1
    fill_in 'category_id', with: 2
    #attach_file 'Image', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

    expect(page).to have_content 'Property successfull created'
    expect(page).to have_content "Hotel 'California'"
    
  end

  scenario 'Authenticated partner create property with errors'

  scenario 'Unauthenticated partner tries to create property'


end

