class RoomsController < ApplicationController
  after_action  :verify_authorized

  def new
    @property = Property.find(params[:property_id])
    @room = @property.rooms.build(prices: [Price.new]) 
    authorize(@room)
  end

  def create    
    @property = Property.find(params[:property_id])    
    @room = @property.rooms.build(room_params)
    authorize(@room)
    
    if @room.save
      flash[:success] = 'Room was added'
      redirect_to partners_root_path
    else
      render 'new'
    end
  end

  def edit
    @room = Room.find(params[:id])
    authorize(@room)
  end

  def update
    @room = Room.find(params[:id])
    authorize(@room)
    # FIXME cocoon add all nested forms from edit
    #@room.prices.destroy_all
    if @room.update room_params
      flash[:success] = 'Room successfully updated'
      redirect_to partners_root_path
    else
      render 'edit'
    end
  end

  def destroy
    @room = Room.find(params[:id])
    authorize(@room)
    @room.destroy
    flash[:success] = 'Room was destroyed'
    redirect_to partners_root_path
  end

  private

  def room_params
    params.require(:room).permit(:title, :property_id, :guest_base_count, :guest_max_count, :avatar,
                                 :description, :serial_number, :room_count, :size,
                                 :bathroom, :beds, :furniture, :in_room, images: [], services: [],
                                 prices_attributes: [:id, :start_date, :end_date, :day_cost, :add_guest_cost, :_destroy])
  end

  def pundit_user
    current_partner
  end
end

