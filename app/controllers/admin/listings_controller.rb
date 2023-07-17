class Admin::ListingsController < Admin::BaseController
  def activate_listing    
    listing = params[:model_name].constantize.find(params[:id])
    listing.activate!
  end
end

