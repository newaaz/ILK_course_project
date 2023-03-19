class SearchController < ApplicationController
  def index
    @properties = BookingSearchService.call(params)

    if params[:check_in].present? && params[:check_out].present?        
      session[:check_in] = params[:check_in]
      session[:check_out] = params[:check_out]
    else
      reset_search_dates
    end

    respond_to do |format|
      format.html { render :index }

      format.turbo_stream do
        render turbo_stream:
          turbo_stream.update('search_result',
            partial: 'search/properties/finded_properties',
            locals:   { properties: @properties })
      end
    end
  end

  def destroy
    reset_search_dates
    redirect_back fallback_location: root_path
  end

  private

  def reset_search_dates
    session.delete(:check_in)
    session.delete(:check_out)
  end
end
