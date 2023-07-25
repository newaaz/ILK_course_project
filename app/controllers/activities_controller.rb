class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show edit update destroy]
  before_action :authorize_activity!

  after_action  :verify_authorized

  def index
    activities = Activity.all
    @pagy, @activities = pagy(activities, items: 12)
  end

  def show
    @town = Town.select(:id, :name, :parent_name).find(params[:town_id]) if params[:town_id].present?
    if @activity.geolocation.present?
      @nearby_properties = @activity.nearby_objects('Property', 5)
      @nearby_activities = @activity.nearby_objects('Activity', 5)
      @nearby_services = @activity.nearby_objects('Service', 5)
    end
  end

  def new
    @activity = Activity.new( geolocation: Geolocation.new,
                              contact: Contact.new,
                              additional_fields: [AdditionalField.new])
  end

  def create
    @activity = current_partner.activities.build(activity_params)
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
    if @activity.update activity_params
      flash[:success] = 'Данные успешно обновлены'
      redirect_to @activity
    else
      respond_to do |format|
        format.html { render 'edit', status: :unprocessable_entity }
      
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update('forms_errors',
              partial: 'shared/errors',
              locals:   { object: @activity })
        end
      end
    end
  end

  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to partners_root_path, notice: 'Объявление удалено' }    
      format.turbo_stream
    end
  end

  private

  def set_activity
    @activity = Activity.includes([:geolocation, :contact, :additional_fields]).find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :address, :category_title, :avatar,
                                      :description, :additional_info, :site, :email, :vk_group,
                                      :price, :price_type, images: [], town_ids: [],
                                      geolocation_attributes: [:id, :latitude, :longitude],                                      
                                      contact_attributes: [:id, :name, :avatar, :phone_number, messengers: [] ],
                                      additional_fields_attributes: [:id, :name, :value, :_destroy])
  end

  def pundit_user
    current_partner
  end

  def authorize_activity!
    authorize(@activity || Activity)
  end
end
