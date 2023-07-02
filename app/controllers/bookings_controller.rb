class BookingsController < ApplicationController
  def create
    @property = Property.find(params[:property_id])
    guest = Partner.first

    @booking = @property.bookings.build(booking_params.merge({ guest: guest }))

    respond_to do |format|    
      if @booking.save
        format.html { redirect_back fallback_location: @property, notice: 'Booking was successfully created.' }
        format.turbo_stream
      else
        format.html { redirect_back fallback_location: @property, status: :unprocessable_entity }
      end    
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :adults, :children, :room_id,
                                    :guest_name, :guest_email, :guest_phone, :message)
  end
end
