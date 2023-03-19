class StaticPagesController < ApplicationController
  def home
    @towns = Town.all
    @homepage_properties = Property.all
  end

  def contacts
    @town = Town.first
    @properties = Property.take 5
  end

  def about
  end

  def privacy
  end
end

