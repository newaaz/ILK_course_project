class Admin::ListingsController < Admin::BaseController
  def index
  end

  # for all listings
  def listings
  end

  def activities    
    activities = Activity.all
    @pagy, @listings = pagy(activities, items: 12)
    render :listings
  end

  def properties
    properties = Property.all
    @pagy, @listings = pagy(properties, items: 12)
    render :listings
  end

  def services
    services = Service.all
    @pagy, @listings = pagy(services, items: 12)
    render :listings
  end

  def activate_listing    
    listing = params[:model_name].constantize.find(params[:id])
    listing.activate!

    respond_to do |format|    
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.replace(listing, partial: "admin/listings/listing", locals: {listing: listing})
      end
    end
  end

  def deactivate_listing    
    listing = params[:model_name].constantize.find(params[:id])
    listing.deactivate!

    respond_to do |format|    
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.replace(listing, partial: "admin/listings/listing", locals: {listing: listing})
      end
    end
  end
end

