class Partners::DashboardController < ApplicationController
  before_action :authorize_dashboard!
  after_action  :verify_authorized

  def index
  	@properties = current_partner.properties.includes(:orders).includes(:rooms)
  end

  private

  def pundit_user
    current_partner
  end

  def authorize_dashboard!
    authorize([:partners, :dashboard])
  end
end
