class FoodPlacesController < ApplicationController
  before_action :set_food_place, only: %i[show edit update destroy]
  before_action :authorize_food_place!

  after_action  :verify_authorized

  def index
    food_places = FoodPlace.activated.select(:id, :title, :avatar, :images, :tags, :town_id, :address)
    @pagy, @food_places = pagy(food_places, items: 12)
  end

  def show
    @town = @food_place.town
    @nearby_properties = @food_place.nearby_objects('Property', 10)
    @nearby_activities = @food_place.nearby_objects('Activity', 10)
    @nearby_services = @food_place.nearby_objects('Service', 10)
    @nearby_places = @food_place.nearby_objects('Place', 10)
    @nearby_food_places = @food_place.nearby_objects('FoodPlace', 10)
  end

  def new
    @food_place = FoodPlace.new(geolocation: Geolocation.new,
                                contact: Contact.new,
                                additional_fields: [AdditionalField.new])
  end

  def create
    @food_place = current_partner.food_places.build(food_place_params)
    if @food_place.save
      flash[:success] = "Объявление добавлено и ожидает проверки. Вам на почту придёт письмо, сообщающее об активации и доступности к просмотру"
      redirect_to @food_place
    else
      respond_to do |format|
        format.html { render 'new', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @food_place })
        end
      end
    end
  end

  def edit    
  end

  def update
    if @food_place.update food_place_params
      flash[:success] = 'Данные успешно обновлены'
      redirect_to @food_place
    else
      respond_to do |format|
        format.html { render 'edit', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @food_place })
        end
      end
    end
  end

  def destroy
    @food_place.destroy

    respond_to do |format|
      format.html { redirect_to partners_root_path, notice: 'Объявление удалено' }    
      format.turbo_stream
    end
  end

  private

  def set_food_place
    @food_place = FoodPlace.includes([:geolocation, :contact, :additional_fields]).find(params[:id])
  end

  def food_place_params
    params.require(:food_place).permit(:title, :address, :menu, :avatar, :town_id,
                                  :description, :site, :email, :vk_group, images: [], tags: [],                               
                                  geolocation_attributes: [:id, :latitude, :longitude],                                      
                                  contact_attributes: [:id, :name, :avatar, :phone_number, messengers: [] ],
                                  additional_fields_attributes: [:id, :name, :value, :_destroy])
  end

  def pundit_user
    current_partner
  end

  def authorize_food_place!
    authorize(@food_place || FoodPlace)
  end
end


