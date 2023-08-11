class SearchController < ApplicationController
  def index
    finded_properties = BookingSearchService.call(params)
    @pagy, @properties = pagy_searchkick finded_properties, items: 12

    if params[:check_in].present? && params[:check_out].present?        
      session[:check_in], session[:check_out] = params[:check_in].to_date, params[:check_out].to_date  
      session[:days_count] = (session[:check_out] - session[:check_in]).to_i + 1
    else
      reset_search_dates
    end

    @town = Town.find(params[:town_id]) if params[:town_id].present?
    @properties_category = Category.find(params[:category_id]) if params[:category_id].present?

    respond_to do |format|
      format.html { render :index }
    end
  end

  # TODO imeplement reset search
  def destroy
    reset_search_dates
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }    
      format.turbo_stream
    end
  end

  private

  def reset_search_dates
    session.delete(:check_in)
    session.delete(:check_out)
    session.delete(:days_count)
  end
end
