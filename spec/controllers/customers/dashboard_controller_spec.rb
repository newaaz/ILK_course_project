require 'rails_helper'

RSpec.describe Customers::DashboardController, type: :controller do
  let(:owner)    { create(:partner) }
  let(:customer) { create(:customer) }
  let(:property) { create_list(:property, owner: owner) }

  describe 'GET #index' do
    context 'Authenticated customer' do
      before do
        sign_in(customer)
        get :index
      end
      it 'populates an array of all orders'

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
