class OrdersController<ApplicationController
  def show
    @order = Order.find(params[:id])
    authorize @order
    @property = Property.select(:title).find(@order.property_id)
    @room = Room.select(:title).find(@order.room_id)
  end

  def new
    authorize Order
    @room = Room.find(params[:room_id])
    @property = @room.property
    @order = Order.new
  end

  def create
    @property = Property.find(params[:property_id])
    @order = current_customer.orders.build(order_params.merge({ property_id: params[:property_id] }))
    authorize @order

    if @order.save
      flash[:info] = 'Order created'
      redirect_to customers_root_path
    else
      render 'new'
    end
  end

  private

  def pundit_user
    current_customer || current_owner
  end

  def order_params
    params.require(:order).permit(:check_in, :check_out, :adults, :kids, :room_id, :wishes_comment,
                                  :customer_name, :customer_phone_number)
  end
end


