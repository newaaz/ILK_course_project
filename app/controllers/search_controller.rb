class SearchController < ApplicationController
  def index
    @properties = BookingSearchService.call(params)
    
    respond_to do |format|
      format.html { render :index }
      
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.update('search_result',
            partial: 'properties/properties',
            locals:   { properties: @properties })
      end
    end
  end
end
