require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:customer) { create :customer }
  let(:partner)  { create :partner }
  let(:property) { create :property, owner: partner }
  let(:room)     { create :room, property: property }
  let(:price)    { create :price, start_date: '2023-05-31', end_date: '2023-09-16', day_cost: 35, room: room }
  let!(:order)   { create :order, property: property, room:room, customer: customer, check_in: price.start_date, check_out: price.start_date + 2 }
  
  let(:other_partner) { create :partner }

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
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'Authenticated customer' do
      before { sign_in(customer) }

      context 'create booking order with valid attributes' do
        it 'saves new order in DB' do
          expect { post :create, params: { order: attributes_for(:order, room_id: room.id, check_in: price.start_date, check_out: price.start_date + 5) } }
                 .to change(Order, :count).by(1)
        end

        it 'redirect to property path' do
          post :create, params: { order: attributes_for(:order, room_id: room.id, check_in: price.start_date, check_out: price.start_date + 5) }      
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
        expect(response).to redirect_to root_path
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
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authenticated partner' do
      before { sign_in(partner) }

      it 'accept order to their property' do
        patch :update, params: { id: order, status_action: 'accept' }
        order.reload
        expect(order.status).to eq 'accepted'
      end
    end

    context 'Authenticated partner' do
      before do
        sign_in(partner)
        order.rejected!
      end

      it 'accept REJECTED order to their property' do
        patch :update, params: { id: order, status_action: 'accept' }
        order.reload
        expect(order.status).to eq 'rejected'
      end
    end

    context 'Other authenticated partner' do
      before { sign_in(other_partner) }

      it 'accept order to other owner property' do
        patch :update, params: { id: order, status_action: 'accept' }
        order.reload
        expect(order.status).to eq 'received'
      end
    end

    context 'Authenticated customer' do
      before { sign_in(customer) }

      it 'accept order to other owner property' do
        patch :update, params: { id: order, status_action: 'accept' }
        order.reload
        expect(order.status).to eq 'received'
      end
    end

    context 'Unauthenticated user' do
      it 'accept order to other owner property' do
        patch :update, params: { id: order, status_action: 'accept' }
        order.reload
        expect(order.status).to eq 'received'
      end
    end

    
  end
end
