class RoomsController < ApplicationController
  after_action  :verify_authorized

  def new
    property = Property.find(params[:property_id])
    room = property.rooms.build(prices: [Price.new]) 
    authorize(room)

    if property.rooms.any?
      @sample_rooms = property.rooms.select(:id, :title)
    end

    respond_to do |format|
      format.html { render 'new', locals: { property: property, room: room } }
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.update('room_form',
            partial: 'rooms/form',
            locals:   { property: property, room: Room.sample_data(params[:sample_room].to_i) })
      end
    end    
  end

  def create    
    @property = Property.find(params[:property_id])    
    @room = @property.rooms.build(room_params)
    authorize(@room)

    if @property.rooms.any?
      @sample_rooms = @property.rooms.select(:id, :title)
    end
    
    if @room.save
      flash[:success] = 'Номер добавлен'
      redirect_to partners_root_path
    else
      respond_to do |format|
        format.html { render 'new', locals: { property: @property, room: @room }, status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @room })
        end
      end
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
                                 :description, :serial_number, :rooms_count, :size,
                                 :bathroom, :beds, :furniture, :in_room, images: [], services: [],
                                 prices_attributes: [:id, :start_date, :end_date, :day_cost, :add_guest_cost, :_destroy])
  end

  def pundit_user
    current_partner
  end
end

