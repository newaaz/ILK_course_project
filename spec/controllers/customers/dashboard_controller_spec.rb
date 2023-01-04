require 'rails_helper'

RSpec.describe Customers::DashboardController, type: :controller do
  let(:owner)    { create(:partner) }
  let(:customer) { create(:customer) }

  describe 'GET #index' do
    let!(:orders)  { create_list(:order, 3, customer: customer) }

    context 'Authenticated customer' do
      before do
        sign_in(customer)
        get :index
      end
      it 'populates an array of all orders' do
        expect(assigns(:orders)).to match_array(orders)
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

    context 'Authenticated partner' do
      before do
        sign_in(owner)
        get :index
      end
  
      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
