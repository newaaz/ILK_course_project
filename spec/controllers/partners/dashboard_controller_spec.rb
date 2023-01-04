require 'rails_helper'

RSpec.describe Partners::DashboardController, type: :controller do
  let(:owner)      { create(:partner) }
  let(:customer)   { create(:customer) }
  let(:properties) { create_list(:property, 3, owner: owner) }
  let!(:orders)    { create_list(:order, 3, property: properties.first) }

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

  describe 'GET #orders' do
    context 'Authenticated partner' do
      before do
        sign_in(owner)
        get :orders
      end
   
      it 'populates an array of all orders belonging to property' do
        expect(assigns(:orders)).to match_array(orders)
      end

      it 'renders orders view' do
        expect(response).to render_template :orders
      end
    end

    context 'Unauthenticated user' do
      before do
        get :orders
      end
  
      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Authenticated customer' do
      before do
        sign_in(customer)
        get :orders
      end
  
      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
