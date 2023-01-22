require 'rails_helper'

feature 'The user can view nearby properties of the shown property', %q{
  In order to see other hotels nearby
  As an visitor
  I'd like to be able view nearby properties of the shown property
} do

  given(:properties)  { create_list :property, 3, :imagable }

  given(:customer)  { create :customer }
  given(:partner)   { create :partner }
  

  scenario 'with valid attributes' do
    visit property_path(properties[0])

    within ".nearby_properties" do
      expect(page).to have_content "Hotel 'Alexandra'", count: 2
    end
  end

end

