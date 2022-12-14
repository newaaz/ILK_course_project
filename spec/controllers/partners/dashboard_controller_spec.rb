require 'rails_helper'

RSpec.describe Partners::DashboardController, type: :controller do
  let(:owner)      { create(:partner) }
  let(:customer)   { create(:customer) }
  let(:properties) { create_list(:property, 3, owner: owner) }

  describe 'GET #index' do
    context 'Authenticated partner' do
      before do
        sign_in(owner)
        get :index
      end
      it 'populates an array of all properties' do         
        expect(assigns(:properties)).to match_array(properties)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end

      it 'populates an array of all orders belongin to property'
    end

    context 'Unauthenticated user' do
      before do
        get :index
      end
  
      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Authenticated customer' do
      before do
        sign_in(customer)
        get :index
      end
  
      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
