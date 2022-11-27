class TownsController < ApplicationController  
  def show
    @town = Town.find(params[:id])
    @properties = @town.properties
  end

  # all town hotels
  def hotels
    @town = Town.find(params[:id])
  end 
end
