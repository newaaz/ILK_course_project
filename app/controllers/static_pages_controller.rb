class StaticPagesController < ApplicationController
  def home
    @towns = Town.all
    @properties = Property.activated.take 6
    @activities = Activity.activated.where(rating: 15).select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address).take 6
    @services = Service.activated.where(rating: 15).select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address).take 6
    @places = Place.activated.where(rating: 15).select(:id, :title, :avatar, :images, :category_title, :town_id, :address).take 6
    @food_places = FoodPlace.where(rating: 15).activated.select(:id, :title, :avatar, :images, :tags, :town_id, :address).take 6
  end

  def contacts
    @town = Town.all.sample
  end

  def about
    @town = Town.all.sample    #  Town.find(Town.ids.sample) || Town.find(Town.pluck(:id).sample)
  end

  def privacy; end

  def agreement; end

  def join_us; end
end
