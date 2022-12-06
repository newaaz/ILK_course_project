class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  #before_action :authenticate_partner!, only: %i[new create edit update destroy]

  before_action :authorize_property!

  after_action  :verify_authorized

  def index
    @properties = Property.all
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = current_partner.properties.build(property_params)
    if @property.save
      flash[:success] = 'Property successfull created'
      redirect_to @property
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @property.update property_params
      redirect_to @property
    else
      render 'edit'
    end
  end

  def destroy
    @property.destroy
    flash[:success] = 'Property was destroyed'
    redirect_to partners_root_path
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:title, :address, :town_id, :category_id, :avatar, images: [])
  end

  def pundit_user
    current_partner
  end

  def authorize_property!
    authorize(@property || Property)
  end
end
