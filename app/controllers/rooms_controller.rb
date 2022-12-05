class RoomsController < ApplicationController
  after_action  :verify_authorized

  def new
    @property = Property.find(params[:property_id])
    @room = @property.rooms.build
    #@room = @property.rooms.build(prices: [Price.new])
    authorize(@room)
    #@room.prices.new
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
    # FIXME cocoon add all nested forms
    @room.prices.destroy_all
    if @room.update room_params
      redirect_to partners_root_path
    else
      render 'edit'
    end
  end

  def destroy
    @room = Room.find(params[:id])
    authorize(@room)
    @room.destroy
    redirect_to partners_root_path
  end

  private

  def room_params
    params.require(:room).permit(:title, :property_id, :guest_base_count, :guest_max_count,
                                 :avatar, images: [],
                                 prices_attributes: [:start_date, :end_date, :day_cost, :add_guest_cost, :_destroy])
  end

  def pundit_user
    current_partner
  end
end

