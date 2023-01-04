class TownsController < ApplicationController  
  def show
    @town = Town.find(params[:id])
    @categories = Category.all

    if params[:cat].blank?
      @properties = @town.properties
    else
      @properties = @town.properties.where(category_id: params[:cat])
      @properties_category = Category.find(params[:cat]).title
    end  
  end
end

