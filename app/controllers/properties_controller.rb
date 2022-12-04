class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :authenticate_partner!, only: %i[new create edit update destroy]

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
      flash[:success] = 'Property was created'
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
    redirect_to root_path
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:title, :address, :town_id, :category_id)
  end  
end
