class BookingsController < ApplicationController
  invisible_captcha only: [:create], honeypot: :subtitle

  before_action :ensure_frame_response, only: [:new]
  
  def new
    @property = Property.find(params[:property_id])
    authorize @property, policy_class: BookingPolicy
    @booking = Booking.new
    @room = @property.rooms.select(:id, :title).find(params[:room].to_i) if params[:room].present?
  end

  def create  
    @property = Property.find(params[:property_id])
    authorize @property, policy_class: BookingPolicy
    @room = @property.rooms.select(:id, :title).find(params[:booking][:room_id].to_i) if params[:booking][:room_id].present?
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

  def ensure_frame_response
    return unless Rails.env.development?
    redirect_back(fallback_location: root_path) unless turbo_frame_request?
  end

  def pundit_user
    current_partner
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :adults, :children, :room_id,
                                    :guest_name, :guest_email, :guest_phone, :message)
  end
end
