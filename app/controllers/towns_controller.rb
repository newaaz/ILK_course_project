class TownsController < ApplicationController  
  def show
    @town = Town.find(params[:id])

    @categories = Category.all
  end

  def properties
    @town = Town.find(params[:id])
    @categories = Category.all

    if params[:cat].blank?
      @properties = @town.properties.activated.includes([:avatar_attachment])
    else
      @properties = @town.properties.activated.includes([:avatar_attachment]).where(category_id: params[:cat])
      @properties_category = Category.find(params[:cat]).title
    end
  end

end

