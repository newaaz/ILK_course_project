class StaticPagesController < ApplicationController
  def home
    @towns = Town.all
    @properties = Property.activated.with_attached_avatar.with_attached_images.take 3
    @activities = Activity.activated.select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address).take 6
  end

  def contacts
    @town = Town.all.sample
  end

  def about
    @town = Town.all.sample    #  Town.find(Town.ids.sample) || Town.find(Town.pluck(:id).sample)
  end

  def privacy
  end

  def agreement    
  end
end

