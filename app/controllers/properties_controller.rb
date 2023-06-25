class PropertiesController < ApplicationController
  before_action :set_property, only: %i[edit update destroy]
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
    @properties = Property.take 3
  end

  def show
    @property = Property.includes([:geolocation, :property_detail, :contact, :town, :category,
                                   images_attachments: :blob, avatar_attachment: :blob,
                                   rooms: [:prices, images_attachments: :blob, avatar_attachment: :blob]])
                        .find(params[:id])
    @nearby_properties = @property.nearby_objects('Property', 20)
    @order = Order.new
  end

  def new
    @property = Property.new(geolocation: Geolocation.new, property_detail: PropertyDetail.new, contact: Contact.new)
  end

  def create
    #debugger
    @property = current_partner.properties.build(property_params)
    if @property.save
      flash[:success] = "Объявление добавлено и ожидает проверки. Вам на почту придёт письмо, сообщающее об активации и доступности к просмотру"
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
      flash[:success] = 'Property successfully updated'
      redirect_to @property
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to partners_root_path, flash[:success] = 'Объявление удалено' }
    
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.remove("property_#{@property.id}")
      end
    end
  end

  private

  def set_property
    @property = Property.includes([:geolocation, :contact, :property_detail]).find(params[:id])
  end

  def property_params
    params.require(:property).permit(:title, :address, :town_id, :category_id, :avatar,
                                      :distance_to_sea, :price_from, images: [], services: [],
                                      geolocation_attributes: [:id, :latitude, :longitude],
                                      contact_attributes: [:id, :email, :name, :phone_number, messengers: [] ],
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
