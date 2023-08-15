class StaticPagesController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper
  
  def home
    @towns = Town.all
    @properties = Property.activated.where(promouted: 5).select(:id, :title, :avatar, :images, :town_id, :category_id, :services, :address, :price_from, :distance_to_sea).take 6
    @activities = Activity.activated.where(promouted: 5).select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address).take 6
    @services = Service.activated.where(promouted: 5).select(:id, :title, :avatar, :images, :category_title, :price, :price_type, :address).take 6
    @places = Place.activated.where(promouted: 5).select(:id, :title, :avatar, :images, :category_title, :town_id, :address).take 6
    @food_places = FoodPlace.where(promouted: 5).activated.select(:id, :title, :avatar, :images, :tags, :town_id, :address).take 6

    set_meta_tags(
      description: "жильё, активный отдых, услуги и сервис в Крыму на сайте Люблю Крым - ilovekrim.ru",
      og: {
        title: "Люблю Крым - ilovekrim.ru",
        description: "жильё, активный отдых, услуги и сервис в Крыму на сайте Люблю Крым - ilovekrim.ru",
        type: "website",
        url: url_for(:only_path => false),
        image: image_url("theme/category/12.jpg"),
        locale: "ru_RU"
      }
    )
  end

  def contacts
    @town = Town.all.sample
  end

  def about
    @town = Town.all.sample    #  Town.find(Town.ids.sample) || Town.find(Town.pluck(:id).sample)
  end

  def privacy; end

  def agreement; end

  def join_us; end
end
