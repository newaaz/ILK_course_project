class TownsController < ApplicationController  
  def show
    @town = Town.find(params[:id])

    @categories = Category.all
  end

  def properties
    @town = Town.find(params[:id])
    @categories = Category.all

    if params[:cat].blank?
      @properties = @town.properties.activated
                                    .with_attached_avatar
                                    .with_attached_images
    else
      @properties = @town.properties.activated
                          .with_attached_avatar
                          .with_attached_images
                          .where(category_id: params[:cat])

      @properties_category = Category.find(params[:cat])  
    end
  end
 
end

