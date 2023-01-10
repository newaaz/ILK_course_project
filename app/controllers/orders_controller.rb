class OrdersController < ApplicationController
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

    case_status_action(params[:status_action])

    redirect_back fallback_location: root_path
  end

  private

  def case_status_action(status_action)
    case  status_action
          when 'accepting'
            accept_order!
          when 'rejecting'
            reject_order!
          end
  end

  def accept_order!
    authorize @order, :accept_order?
    @order.accepted!
  end

  def reject_order!
    authorize @order, :reject_order?
    @order.rejected!
  end

  def pundit_user
    current_customer || current_partner
  end

  def order_params
    params.require(:order).permit(:check_in, :check_out, :adults, :kids, :room_id)
  end
end
