class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show edit update destroy]
  before_action :authorize_activity!

  after_action  :verify_authorized

  def show
    # @rooms = @property.rooms.with_attached_images.with_attached_avatar
    # @nearby_properties = @property.nearby_objects('Property', 20)
    # @booking = Booking.new(property: @property)
  end

  def new
    @activity = Activity.new(listing_type: params[:listing_type].to_s, geolocation: Geolocation.new, contact: Contact.new)
  end

  def create
    
    @activity = current_partner.activities.build(activity_params)
    #debugger
    if @activity.save
      flash[:success] = "Объявление добавлено и ожидает проверки. Вам на почту придёт письмо, сообщающее об активации и доступности к просмотру"
      redirect_to @activity
    else
      respond_to do |format|
        format.html { render 'new', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @activity })
        end
      end
    end
  end

  def edit    
  end

  def update
    # if @property.update property_params
    #   flash[:success] = 'Данные успешно обновлены'
    #   redirect_to @property
    # else
    #   respond_to do |format|
    #     format.html { render 'edit', status: :unprocessable_entity }
      
    #     format.turbo_stream do
    #       render turbo_stream:
    #         turbo_stream.update('forms_errors',
    #           partial: 'shared/errors',
    #           locals:   { object: @property })
    #     end
    #   end
    # end
  end

  def destroy
    # @property.destroy

    # respond_to do |format|
    #   format.html { redirect_to partners_root_path, notice: 'Объект удален' }    
    #   format.turbo_stream
    # end
  end

  private

  def set_activity
    @activity = Activity.includes([:geolocation, :contact,]).find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :address, :category_title, :listing_type, :avatar,
                                      :description, :additional_info,
                                      :price, :price_type, images: [], town_ids: [],
                                      geolocation_attributes: [:id, :latitude, :longitude],
                                      contact_attributes: [:id, :email, :name, :avatar, :phone_number, messengers: [] ])
  end

  def pundit_user
    current_partner
  end

  def authorize_activity!
    authorize(@activity || Activity)
  end
end