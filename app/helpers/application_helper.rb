module ApplicationHelper
  include Pagy::Frontend

  def full_title(page_title = '')
    base_title = "Люблю Крым"
    if page_title.empty?
      base_title
    else
      # page_title + " | " + base_title
      page_title
    end
  end

  def towns_hash
    @towns_hash ||= Town.pluck(:id, :name).to_h
  end 

  def categories_hash
    @categories_hash ||= Category.pluck(:id, :title).to_h
  end

  #TODO refactoring this methods
  def favorite_property_ids
    return [] if session[:favorite_id].nil?
    @favorite_property_ids ||= current_favorite.property_ids
  end

  def favorite_activity_ids
    return [] if session[:favorite_id].nil?
    @favorite_activity_ids ||= current_favorite.activity_ids
  end

  def favorite_service_ids
    return [] if session[:favorite_id].nil?
    @favorite_service_ids ||= current_favorite.service_ids
  end

  def favorite_place_ids
    return [] if session[:favorite_id].nil?
    @favorite_place_ids ||= current_favorite.place_ids
  end

  def favorite_food_place_ids
    return [] if session[:favorite_id].nil?
    @favorite_food_place_ids ||= current_favorite.food_place_ids
  end
end
