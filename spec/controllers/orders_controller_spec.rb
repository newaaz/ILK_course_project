require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:customer) { create(:customer) }
  let(:partner)  { create(:partner) }
  let(:property) { create(:property) }
  let(:room)     { create(:room, property: property) }

  describe 'GET #new' do
    context 'Authenticated customer' do
      before do
        sign_in(customer)
        get :new, params: { room_id: room.id }
      end
      
      it 'assigns a new Order to @order' do
        expect(assigns(:order)).to be_a_new(Order)
      end

      it 'assigns booking room to @room' do
        expect(assigns(:room)).to eq room
      end
  
      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'Unauthenticated customer' do
      before do
        request.env['HTTP_REFERER'] = property_path(property)
        get :new, params: { room_id: room.id }      
      end
  
      it 'redirect to property path' do        
        expect(response).to redirect_to property_path(property)
      end
    end
  end

  describe 'POST #create' do
    context 'Authenticated customer' do
      before { sign_in(customer) }

      context 'create booking order with valid attributes' do
        it 'saves new order in DB' do
          expect { post :create, params: { order: attributes_for(:order, room_id: room.id) } }
                 .to change(Order, :count).by(1)
        end

        it 'redirect to property path' do
          post :create, params: { order: attributes_for(:order, room_id: room.id) }      
          expect(response).to redirect_to property_path(property)
        end
      end

      context 'create booking order with invalid attributes' do
        it 'does not saves new order in DB' do
          expect { post :create, params: { order: attributes_for(:order, :invalid, room_id: room.id) } }
                 .to_not change(Order, :count)
        end

        it 're-renders new view' do
          post :create, params: { order: attributes_for(:order, :invalid, room_id: room.id) }
          expect(response).to render_template :new
        end
      end      
    end

    context 'Unauthenticated customer' do
      before do
        request.env['HTTP_REFERER'] = property_path(property)
      end
      it 'does not saves new order in DB' do
        expect { post :create, params: { order: attributes_for(:order, :invalid, room_id: room.id) } }
               .to_not change(Order, :count)
      end
    
      it 'redirect to customer sign in path' do
        post :create, params: { order: attributes_for(:order, :invalid, room_id: room.id) }
        expect(response).to redirect_to property_path property
      end
    end

    context 'Authenticated partner' do
      before do        
        request.env['HTTP_REFERER'] = property_path(property)
        sign_in(partner)
      end
    
      it 'does not saves new order in DB' do
        expect { post :create, params: { order: attributes_for(:order, :invalid, room_id: room.id) } }
               .to_not change(Order, :count)
      end
    
      it 'redirect to customer sign in path' do
        post :create, params: { order: attributes_for(:order, :invalid, room_id: room.id) }
        expect(response).to redirect_to property_path property
      end
    end
  end
end
