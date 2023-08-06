class FavoritesController < ApplicationController
  #TODO resolve how to include favorite_items in favorite
  def show
    @favorite = Favorite.includes(:favorite_items).find(session[:favorite_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, notice: 'В избранном ничего нет'
  end

  def destroy
    favorite = Favorite.find(session[:favorite_id])
    favorite.destroy
    session[:favorite_id] = nil

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Список избранного очищен'  }
    end
  rescue ActiveRecord::RecordNotFound
    session[:favorite_id] = nil
  end
end
