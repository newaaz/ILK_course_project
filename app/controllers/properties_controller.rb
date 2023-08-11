class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :authorize_property!

  after_action  :verify_authorized

  def calculate_price
    @property = Property.find(params[:id])

    if params[:commit] == 'reset'
      session.delete(:check_in)
      session.delete(:check_out)
      session.delete(:days_count)
      @dates_status = :reset
      return
    end
    
    if params[:check_in].blank? || params[:check_out].blank? || params[:check_in].to_date > params[:check_out].to_date
      @dates_status = :invalid
      return
    end

    begin
      session[:check_in], session[:check_out] = params[:check_in].to_date, params[:check_out].to_date    
      session[:days_count] = (session[:check_out] - session[:check_in]).to_i

      @dates_status = :set
    rescue Date::Error
      render turbo_stream: turbo_stream.update('flash_messages',
                                                  partial: 'shared/flash_message',
                                                  locals: {
                                                    message_type: 'info',
                                                    message: 'Неправильный формат даты'
                                                  })
    end
    
  end

  def index
    if params[:cat].blank?
      properties = Property.activated  
    else
      properties = Property.activated.where(category_id: params[:cat])
      @properties_category = Category.find(params[:cat])      
    end
    @categories = Category.all
    @pagy, @properties = pagy(properties, items: 12)
  end

  def show
    @rooms = @property.rooms.order(:serial_number)
    @nearby_properties = @property.nearby_objects('Property', 5)
    @nearby_activities = @property.nearby_objects('Activity', 5)
    @nearby_services = @property.nearby_objects('Service', 5)
    @nearby_places = @property.nearby_objects('Place', 5)
    @booking = Booking.new(property: @property)
  end

  def new
    @property = Property.new(geolocation: Geolocation.new,
                             property_detail: PropertyDetail.new,
                             additional_fields: [AdditionalField.new],
                             contact: Contact.new)
  end

  def create
    @property = current_partner.properties.build(property_params)
    if @property.save
      flash[:success] = "Объявление добавлено и ожидает проверки. После активации вам на почту придёт письмо"
      redirect_to @property
    else
      respond_to do |format|
        format.html { render 'new', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @property })
        end
      end
    end
  end

  def edit    
  end

  def update
    if @property.update property_params
      flash[:success] = 'Данные успешно обновлены'
      redirect_to @property
    else
      respond_to do |format|
        format.html { render 'edit', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @property })
        end
      end
    end
  end

  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to partners_root_path, notice: 'Объект удален' }    
      format.turbo_stream
    end
  end

  private

  def set_property
    @property = Property.includes([:geolocation, :property_detail, :contact, :town, :category]).find(params[:id])
  end

  def property_params
    params.require(:property).permit(:title, :address, :town_id, :category_id, :avatar,
                                      :distance_to_sea, :price_from, images: [], services: [],
                                      geolocation_attributes: [:id, :latitude, :longitude],
                                      contact_attributes: [:id, :email, :name, :avatar, :phone_number, messengers: [] ],
                                      additional_fields_attributes: [:id, :name, :value, :_destroy],
                                      property_detail_attributes: [:id, :short_description,
                                        :parking, :rating, :food, :territory, :additional_info,
                                        :transfer, :site, :email, :vk_group, amenities: []])
  end

  def pundit_user
    current_partner
  end

  def authorize_property!
    authorize(@property || Property)
  end
end
