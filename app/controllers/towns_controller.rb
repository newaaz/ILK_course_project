class TownsController < ApplicationController
  before_action :set_town, except: [:index]

  def index
    @towns = Town.all
  end

  def show
    @categories = Category.all
    @promo_properties = @town.properties.activated.where(promouted: 5).take(6)
    @promo_activities = @town.activities.activated.where(promouted: 5).take(6)

    @promo_services = @town.services.activated.where(promouted: 5).take(6)
    #@taxi_services = @promo_services.select { |service| service.promouted == 10 }
    #@food_delivery_services = @promo_services.select { |service| service.promouted == 10 }
    @taxi_services = @town.services.activated.where(promouted: 10, category_title: 'Такси').take(2)
    @food_delivery_services = @town.services.activated.where(promouted: 10, category_title: "Доставка еды").take(2)

    @promo_food_places = @town.food_places.activated.where(promouted: 5).take(6)
    @promo_places = @town.places.activated.where(promouted: 5).take(6)
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
