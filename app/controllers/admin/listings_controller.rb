class Admin::ListingsController < ApplicationController
  def activate_listing    
    listing = params[:model_name].constantize.find(params[:id])
    listing.activate!
  end
end

