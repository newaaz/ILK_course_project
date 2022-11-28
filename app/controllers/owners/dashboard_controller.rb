class Owners::DashboardController < ApplicationController
  before_action :authorize_dashboard!
  after_action  :verify_authorized

  def index
  	@properties = current_owner.properties.includes(:rooms)
  end

  private

  def pundit_user
    current_owner
  end

  def authorize_dashboard!
    authorize([:owners, :dashboard])
  end
end