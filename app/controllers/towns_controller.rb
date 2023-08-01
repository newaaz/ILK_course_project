class TownsController < ApplicationController
  before_action :set_town, except: [:index]

  def index
    @towns = Town.all
  end

  def show
    @categories = Category.all
  end

  def properties
    if params[:cat].blank?
      properties = @town.properties.activated 
    else
      properties = @town.properties.activated.where(category_id: params[:cat])
      @properties_category = Category.find(params[:cat])      
    end
    @categories = Category.all
    @pagy, @properties = pagy(properties, items: 12)
  end

  def activities
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
    if params[:category_title].present?
      services = @town.services.activated
                               .select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
                               .where(category_title: params[:category_title])
      @category_title = params[:category_title]
    else
      services = @town.services.activated.select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address)
    end
    @pagy, @services = pagy(services, items: 12)
  end

  def places
    if params[:category_title].present?
      places = @town.places.activated
                           .select(:id, :title, :avatar, :images, :category_title, :town_id, :address)
                           .where(category_title: params[:category_title])
      @category_title = params[:category_title]
    else
      places = @town.places.activated.select(:id, :title, :avatar, :images, :category_title, :town_id, :address)
    end
    @pagy, @places = pagy(places, items: 12)
  end

  def food_places
    food_places = @town.food_places.activated.select(:id, :title, :avatar, :images, :town_id, :address, :tags)
    @pagy, @food_places = pagy(food_places, items: 12)
  end

  private

  def set_town
    @town = Town.find(params[:id])
  end
end
