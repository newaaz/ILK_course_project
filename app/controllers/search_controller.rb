class SearchController < ApplicationController
  def index
    @properties = params[:search].blank? ? Property.all : Property.search(params[:search], fields: %i[title])
    
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
