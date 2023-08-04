class ApplicationController < ActionController::Base
  include Authorized
  include Pagy::Backend

  def current_favorite
    if session[:favorite_id].present?
      Favorite.find(session[:favorite_id])    
    else
      create_new_favorite
    end
  rescue ActiveRecord::RecordNotFound
    create_new_favorite
  end

  helper_method :current_favorite

  private

  def create_new_favorite
    favorite = Favorite.create!
    session[:favorite_id] = favorite.id
    favorite 
  end
end
