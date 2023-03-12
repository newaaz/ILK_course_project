class SearchController < ApplicationController
  def index
    @properties = BookingSearchService.call(params)

    if params[:check_in].present? && params[:check_out].present?        
      session[:check_in] = params[:check_in]
      session[:check_out] = params[:check_out]
    end

    render turbo_stream:
      turbo_stream.update('search_result',
                    partial: 'search/properties/finded_properties',
                    locals:  { properties: @properties })
  end
end
