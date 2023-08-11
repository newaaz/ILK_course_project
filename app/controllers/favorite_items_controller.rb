class FavoriteItemsController < ApplicationController
  def create
    current_item = current_favorite.favorite_items.find_by(listing_type: params[:listing_type], listing_id: params[:listing_id])

    if current_item.present?
      current_item.destroy      

      if current_favorite.items_count == 1
        current_favorite.destroy
        session[:favorite_id] = nil
      else
        current_favorite.update_attribute(:items_count, current_favorite.items_count - 1)
      end
      
      respond_to do |format|        
        format.turbo_stream { @status = "Удалено из избранного", @listing = current_item.listing }
      end
    else
      current_item = current_favorite.favorite_items.build(listing_type: params[:listing_type], listing_id: params[:listing_id])
      respond_to do |format| 
        if current_item.save
          current_favorite.update_attribute(:items_count, current_favorite.items_count + 1)
          format.turbo_stream { @status = "Добавлено в избранное", @listing = current_item.listing }
        else
          format.turbo_stream { @status = :error }
        end
      end
    end
  end
end
