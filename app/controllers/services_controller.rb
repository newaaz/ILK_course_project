class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy]
  before_action :authorize_service!

  after_action  :verify_authorized

  def index
    if params[:category_title].present?
      services = Service.all.activated
                            .select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
                            .where(category_title: params[:category_title])
      @category_title = params[:category_title]
    else
      services = Service.all.activated.select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
    end

    @pagy, @services = pagy(services, items: 12)
  end

  def show
    if @service.geolocation.present?
      @nearby_properties = @service.nearby_objects('Property', 5)
      @nearby_activities = @service.nearby_objects('Activity', 5)
      @nearby_services = @service.nearby_objects('Service', 5)
    end
  end

  def new
    @service = Service.new( geolocation: Geolocation.new,
                            contact: Contact.new,
                            additional_fields: [AdditionalField.new])
  end

  def create
    @service = current_partner.services.build(service_params)
    if @service.save
      flash[:success] = "Объявление добавлено и ожидает проверки. Вам на почту придёт письмо, сообщающее об активации и доступности к просмотру"
      redirect_to @service
    else
      respond_to do |format|
        format.html { render 'new', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @service })
        end
      end
    end
  end

  def edit    
  end

  def update
    if @service.update service_params
      flash[:success] = 'Данные успешно обновлены'
      redirect_to @service
    else
      respond_to do |format|
        format.html { render 'edit', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @service })
        end
      end
    end
  end

  def destroy
    @service.destroy

    respond_to do |format|
      format.html { redirect_to partners_root_path, notice: 'Объявление удалено' }    
      format.turbo_stream
    end
  end

  private

  def set_service
    @service = Service.includes([:geolocation, :contact, :additional_fields]).find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title, :address, :category_title, :avatar,
                                      :description, :additional_info, :site, :email, :vk_group,
                                      :price, :price_type, images: [], town_ids: [],
                                      geolocation_attributes: [:id, :latitude, :longitude],                                      
                                      contact_attributes: [:id, :name, :avatar, :phone_number, messengers: [] ],
                                      additional_fields_attributes: [:id, :name, :value, :_destroy])
  end

  def pundit_user
    current_partner
  end

  def authorize_service!
    authorize(@service || Service)
  end
end
