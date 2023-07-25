class TownsController < ApplicationController  
  def show
    @town = Town.find(params[:id])
    @categories = Category.all
  end

  def properties
    @town = Town.find(params[:id])
    @categories = Category.all

    if params[:cat].blank?
      properties = @town.properties.activated
                                   .with_attached_avatar
                                   .with_attached_images    
    else
      properties = @town.properties.activated
                        .with_attached_avatar
                        .with_attached_images
                        .where(category_id: params[:cat])

      @properties_category = Category.find(params[:cat])      
    end

    @pagy, @properties = pagy(properties, items: 12)
  end

  def activities
    @town = Town.find(params[:id])

    if params[:category_title].present?
      activities = @town.activities.activated
                           .select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
                           .where(category_title: params[:category_title])
      @category_title = params[:category_title]
    else
      activities = @town.activities.activated
                          .select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
    end

    @pagy, @activities = pagy(activities, items: 12)
  end

  def services
    @town = Town.find(params[:id])

    if params[:category_title].present?
      services = @town.services.activated
                           .select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
                           .where(category_title: params[:category_title])
      @category_title = params[:category_title]
    else
      services = @town.services.activated
                          .select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
    end

    @pagy, @services = pagy(services, items: 12)
  end 
end

