require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  let(:owner)         { create(:partner) }
  let(:another_owner) { create(:partner) }
  let(:category)      { create(:category) }
  let(:town)          { create(:town) }
  let(:property)      { create(:property, owner: owner, town: town, category: category) }
  let(:room)          { create(:room, :imagable, property: property) }
  let(:image_id)      { room.images.first.id }

  describe 'DELETE #purge' do
    context "Authenticated owner of the room's property" do
      before { sign_in(owner) }

      it 'deletes the images from DB' do
        expect { delete :purge, params: { id: image_id } }.to change(room.images, :count).by(-1)
      end

      it "redirect back on view edit" do
        request.env['HTTP_REFERER'] = edit_room_path(room)
        delete :purge, params: { id: image_id }
        expect(response).to redirect_to edit_room_path(room)
      end
    end

    context "Authenticated non-owner of the room's property" do
      before { sign_in(another_owner) }

      it 'does not deletes the room from DB' do
        expect { delete :purge, params: { id: image_id } }.to_not change(room.images, :count)
      end

      it "redirect to root path" do
        delete :purge, params: { id: image_id }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated partner' do
      it 'does not deletes the room from DB' do
        expect { delete :purge, params: { id: image_id } }.to_not change(room.images, :count)
      end

      it "redirect to root path" do
        delete :purge, params: { id: image_id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
