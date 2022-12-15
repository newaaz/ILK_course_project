require 'rails_helper'

RSpec.describe TownsController, type: :controller do
  let(:town)      { create(:town) }
  let(:cat_hotel) { create(:category, title: 'Hotels') }
  let(:cat_flat)  { create(:category, title: 'Flats') }
  let(:hotels)    { create_list(:property, 3, town: town, category: cat_hotel) }
  let(:flats)     { create_list(:property, 3, town: town, category: cat_flat) }  

  describe 'GET #show' do
    context 'Properties list of all categories' do
      let(:all_properties) { hotels + flats }

      before { get :show, params: { id: town } }

      it 'populates an array of all properties' do         
        expect(assigns(:properties)).to match_array(all_properties)
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end

    context 'Properties list of selected category' do
      before { get :show, params: { id: town, cat: cat_flat } }

      it 'populates an array of all properties' do         
        expect(assigns(:properties)).to match_array(flats)
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end
  end
end
