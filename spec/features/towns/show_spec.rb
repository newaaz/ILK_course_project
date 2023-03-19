require 'rails_helper'

feature 'Any user can view properties list of town', %q{
  In order to book property in selected town
  As an any user
  I'd like to be able to view properties list selected town
} do

  given!(:town)      { create(:town) }
  given!(:cat_hotel) { create(:category, title: 'Hotels') }
  given!(:cat_flat)  { create(:category, title: 'Flats') }
  given!(:hotels)    { create_list(:property, 3, :imagable, :reindex, town: town, category: cat_hotel) }
  given!(:flats)     { create_list(:property, 3, :imagable, :reindex, town: town, category: cat_flat) }

  background do
    visit root_path
    within ".links-towns-show" do
      click_on town.name
    end
  end

  scenario 'Properties list of all categories', js: true do
    expect(page).to have_content "Properties in #{town.parent_name}" 
    expect(page).to have_content "Hotel 'Alexandra'", count: 6
  end

  scenario 'Properties list of selected category', js: true do
    click_on "#{cat_hotel.title}"

    expect(page).to have_content "#{cat_hotel.title} in #{town.parent_name}" 
    expect(page).to have_content "Hotel 'Alexandra'", count: 3
  end
end
