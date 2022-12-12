require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:owner)         { create(:partner) }
  let(:another_owner) { create(:partner) }
  let(:category)      { create(:category) }
  let(:town)          { create(:town) }
  let(:property)      { create(:property, owner: owner, town: town, category: category) }
  let(:room)          { create(:room, property: property) }

  describe 'GET #new' do
    context 'Authencticated owner of property' do
      before do
        sign_in(owner)
        get :new, params: { property_id: property.id }
      end

      it 'assigns a property from params to @property' do
        expect(assigns(:property)).to eq property
      end

      it 'assigns a new Room to @room' do
        expect(assigns(:room)).to be_a_new(Room)
      end

      it 'assigns a new Price for room' do
        expect(assigns(:room).prices.first).to be_a_new(Price)
      end

      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'Authenticated non-owner of property' do
      it 'redirect to root path' do
        sign_in(another_owner)
        get :new, params: { property_id: property.id }

        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user tries add room' do
      it 'redirect to root path' do
        get :new, params: { property_id: property.id }

        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'Authencticated owner of property' do
      before { sign_in(owner) }

      context 'add room with valid attributes' do
        it 'saves new room in DB' do
          expect { post :create, params: { property_id: property.id, room: attributes_for(:room) } }.to change(Room, :count).by(1)
        end

        it 'correct property for room' do
          post :create, params: { property_id: property.id, room: attributes_for(:room) }
          expect(Room.last).to eq property.rooms.last
        end
  
        it 'redirect to dashboard' do
          post :create, params: { property_id: property.id, room: attributes_for(:room) }
          expect(response).to redirect_to partners_root_path
        end
      end

      context 'add room with invalid attributes' do
        it 'does not save the room in DB' do
          expect { post :create, params: { property_id: property.id, room: attributes_for(:room, :invalid) } }.to_not change(Room, :count)
        end
  
        it 're-renders new view' do
          post :create, params: { property_id: property.id, room: attributes_for(:room, :invalid) }
          expect(response).to render_template :new
        end
      end
    end

    context 'Authenticated non-owner of property tries add room' do
      before { sign_in(another_owner) }

      it 'does not save the room in DB' do
        expect { post :create, params: { property_id: property.id, room: attributes_for(:room) } }.to_not change(Room, :count)
      end

      it 'redirect to root_path' do
        post :create, params: { property_id: property.id, room: attributes_for(:room) }
        expect(response).to redirect_to root_path
      end

    end

    context 'Unauthenticated user tries add room' do
      it 'does not save the room in DB' do
        expect { post :create, params: { property_id: property.id, room: attributes_for(:room) } }.to_not change(Room, :count)
      end

      it 'redirect to root_path' do
        post :create, params: { property_id: property.id, room: attributes_for(:room) }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #edit' do
  
    context 'Authenticated partner, owner of the property' do
      before do
        sign_in(owner)
        get :edit, params: { id: room }
      end

      it 'assigns requested room to @room' do
        expect(assigns(:room)).to eq room
      end
  
      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'Authenticated partner, non-owner of the property' do
      before do
        sign_in(another_owner)
        get :edit, params: { id: room }
      end

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated partner' do
      before { get :edit, params: { id: room } }
      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'PATCH #update' do
    context 'Authenticated correct partner update property' do
      before { sign_in(owner) }

      context 'with valid attributes' do      
        before { patch :update, params: { id: room, room: attributes_for(:room, title: 'updated room title')  } }
  
        it 'assigns the requested room to @room' do
          expect(assigns(:room)).to eq room
        end
  
        it 'changes room attributes' do
          room.reload
          expect(room.title).to eq 'updated room title'
        end
  
        it 'redirect to dashboard view' do
          expect(response).to redirect_to partners_root_path
        end
      end

      context 'with valid attributes' do      
        before { patch :update, params: { id: room, room: attributes_for(:room, title: '')  } }

        it 'does not changes room attributes' do
          room.reload
          expect(room.title).to eq 'Standard 3-x'
        end
  
        it 'render edit view' do
          expect(response).to render_template :edit
        end  
      end
    end

    context "Another authenticated partner tries to update someone else's properties room" do
      before do
        sign_in(another_owner)
        patch :update, params: { id: room, room: attributes_for(:room, title: 'updated room title')  }
      end

      it 'does not change property attributes' do
        room.reload
        expect(room.title).to eq 'Standard 3-x'
      end

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user tries update property' do
      before { patch :update, params: { id: room, room: attributes_for(:room, title: 'updated room title')  } }

      it 'does not change property attributes' do
        room.reload
        expect(room.title).to eq 'Standard 3-x'
      end

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:room) { create(:room, property: property) }

    context 'authenticated owner of the room' do
      before { sign_in(owner) }

      it 'deletes the room from DB' do
        expect { delete :destroy, params: { id: room } }.to change(Room, :count).by(-1)
      end

      it "redirect to partners's dashboard" do
        delete :destroy, params: { id: room }
        expect(response).to redirect_to partners_root_path
      end
    end

    context 'authenticated non-owner of the room' do
      before { sign_in(another_owner) }

      it 'does not deletes the room from DB' do
        expect { delete :destroy, params: { id: room } }.to_not change(Room, :count)
      end

      it "redirect to partners's dashboard" do
        delete :destroy, params: { id: room }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated partner' do
      it 'does not deletes the room from DB' do
        expect { delete :destroy, params: { id: room } }.to_not change(Room, :count)
      end

      it "redirect to partners's dashboard" do
        delete :destroy, params: { id: room }
        expect(response).to redirect_to root_path
      end
    end
  end
end




