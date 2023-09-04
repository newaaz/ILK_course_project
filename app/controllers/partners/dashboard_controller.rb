class Partners::DashboardController < ApplicationController
  before_action :authorize_dashboard!
  after_action  :verify_authorized

  def index
  	@properties = current_partner.properties.includes([:orders, :town, :category, :property_detail])
    @activities = current_partner.activities
    @services = current_partner.services
    @places = current_partner.places
    @food_places = current_partner.food_places
  end

  def orders
    @orders = current_partner.owner_orders
  end

  def bookings
    @bookings = current_partner.as_hoster_bookings.includes(:property)
  end

  def cancel_mailing
    render turbo_stream:
      turbo_stream.update('flash_messages',
                          partial: 'shared/flash_message',
                          locals: {
                            message_type: 'info',
                            message: 'Рассылка отключена'
                          })
  end

  def profile; end

  def add_listing; end

  def info; end

  private

  def pundit_user
    current_partner
  end

  def authorize_dashboard!
    authorize([:partners, :dashboard])
  end
end
