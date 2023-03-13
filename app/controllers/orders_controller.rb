class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def new
    authorize Order
    @room = Room.find(params[:room_id])
    @property = @room.property
    @order = Order.new
  end

  def create
    authorize Order
    @room = Room.find(params[:order][:room_id])
    @property = @room.property
    @order = current_customer.orders.build(order_params.merge({ property_id: @property.id }))

    if @order.save
      flash[:info] = "Order №-#{@order.id} to #{@property.title} in #{@room.title} created. Total: #{@order.total_amount}"
      redirect_to property_path @property
    else
      render 'new'
    end
  end

  def update
    @order = Order.find(params[:id])

    authorize @order, authorized_action(params[:status_action])

    @order.change_status(params[:status_action])

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@order, partial: 'orders/order', locals: { order: @order }) }
    end
  end

  private

  def authorized_action(status_action)
    (status_action + '_order?').to_sym
  end

  def pundit_user
    current_customer || current_partner
  end

  def order_params
    params.require(:order).permit(:check_in, :check_out, :adults, :kids, :room_id)
  end
end
