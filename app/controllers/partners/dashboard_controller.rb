class Partners::DashboardController < ApplicationController
  before_action :authorize_dashboard!
  after_action  :verify_authorized

  def index
  	@properties = current_partner.properties.includes([:orders, :town, :category, :property_detail,
                                                        avatar_attachment: :blob,
                                                        rooms: [avatar_attachment: :blob]])
  end

  def orders
    @orders = current_partner.owner_orders
  end

  def bookings
    @bookings = current_partner.as_hoster_bookings.includes(:property)
  end

  def profile
  end

  def add_listing
  end

  private

  def pundit_user
    current_partner
  end

  def authorize_dashboard!
    authorize([:partners, :dashboard])
  end
end
