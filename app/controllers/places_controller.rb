class PlacesController < ApplicationController
  before_action :set_place, only: %i[show edit update destroy]
  before_action :authorize_place!

  after_action  :verify_authorized

  def index
    if params[:category_title].present?
      places = Place.activated
                    .select(:id, :title, :avatar, :images, :category_title, :town_id, :address)
                    .where(category_title: params[:category_title])
      @category_title = params[:category_title]
    else
      places = Place.activated.select(:id, :title, :avatar, :images, :category_title, :town_id, :address)
    end

    @pagy, @places = pagy(places, items: 12)
  end

  def show
    @town = @place.town
    @nearby_properties = @place.nearby_objects('Property', 10)
    @nearby_activities = @place.nearby_objects('Activity', 10)
    @nearby_services = @place.nearby_objects('Service', 10)
    @nearby_places = @place.nearby_objects('Place', 10)
    @nearby_food_places = @place.nearby_objects('FoodPlace', 10)
  end

  def new
    @place = Place.new( geolocation: Geolocation.new,
                        contact: Contact.new,
                        additional_fields: [AdditionalField.new])
  end

  def create
    @place = current_partner.places.build(place_params)
    if @place.save
      flash[:success] = "Объявление добавлено и ожидает проверки. Вам на почту придёт письмо, сообщающее об активации и доступности к просмотру"
      redirect_to @place
    else
      respond_to do |format|
        format.html { render 'new', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @place })
        end
      end
    end
  end

  def edit    
  end

  def update
    if @place.update place_params
      flash[:success] = 'Данные успешно обновлены'
      redirect_to @place
    else
      respond_to do |format|
        format.html { render 'edit', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @place })
        end
      end
    end
  end

  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to partners_root_path, notice: 'Объявление удалено' }    
      format.turbo_stream
    end
  end

  private

  def set_place
    @place = Place.includes([:geolocation, :contact, :additional_fields]).find(params[:id])
  end

  def place_params
    params.require(:place).permit(:title, :address, :category_title, :avatar, :town_id, :how_to_get,
                                  :description, :site, :email, :vk_group, images: [],                                  
                                  geolocation_attributes: [:id, :latitude, :longitude],                                      
                                  contact_attributes: [:id, :name, :avatar, :phone_number, messengers: [] ],
                                  additional_fields_attributes: [:id, :name, :value, :_destroy])
  end

  def pundit_user
    current_partner
  end

  def authorize_place!
    authorize(@place || Place)
  end
end


