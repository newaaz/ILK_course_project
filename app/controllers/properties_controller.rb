class PropertiesController < ApplicationController
  before_action :set_property, only: %i[edit update destroy]
  before_action :authorize_property!

  after_action  :verify_authorized

  def index
    @properties = Property.take 3
  end

  def show
    @property = Property.includes([:geolocation, :property_detail, :contact, :town, :category,
                                   images_attachments: :blob, avatar_attachment: :blob,
                                   rooms: [:prices, images_attachments: :blob, avatar_attachment: :blob]])
                        .find(params[:id])

    @nearby_properties = @property.nearby_objects('Property')
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
    flash[:success] = 'Объявление удалено'
    redirect_to partners_root_path
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
