class SearchController < ApplicationController
  def index

    category_id = params[:category_id].present? ? params[:category_id].to_i : Category.ids

    town_id = params[:town_id].present? ? params[:town_id].to_i : Town.ids

    search_params = {}
    search_params = search_params.merge(town_id:     params[:town_id].to_i)     if params[:town_id].present?
    search_params = search_params.merge(category_id: params[:category_id].to_i) if params[:category_id].present?

    if params[:guests].present?
      #search_params = search_params.merge("rooms.guest_base_count" => 2)
      guest_number_query = {
                            "rooms.guest_base_count" => { lte: params[:guests] },
                            _and: ["rooms.guest_max_count" => { gte: params[:guests] }]
                           }

      search_params = search_params.merge guest_number_query
    
    end

    @properties = Property.search(fields: %i[category_id town_id rooms], where: search_params)
    
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
