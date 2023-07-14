class BookingsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @booking = Booking.new
    authorize @property, policy_class: BookingPolicy
  end

  def create
    @property = Property.find(params[:property_id])
    authorize @property, policy_class: BookingPolicy
    # TODO redefine guest
    guest = Partner.first

    @booking = @property.bookings.build(booking_params.merge({ guest: guest }))

    respond_to do |format|
      if @booking.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('flash_messages',
                                              partial: 'shared/flash_message',
                                              locals: {
                                                message_type: 'info',
                                                message: 'Заявка отправлена. В ближайшее время с Вами должны связаться по указанным контактам'
                                              })
        end
        format.html { redirect_to @property, notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def pundit_user
    current_partner
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :adults, :children, :room_id,
                                    :guest_name, :guest_email, :guest_phone, :message)
  end
end
