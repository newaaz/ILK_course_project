class StaticPagesController < ApplicationController
  def home
    @towns = Town.all
    @properties = Property.activated.with_attached_avatar.with_attached_images.take 6    
  end

  def contacts
    @town = Town.first
    @properties = Property.activated.with_attached_images.with_attached_avatar.take 6
  end

  def about
  end

  def privacy
  end
end

