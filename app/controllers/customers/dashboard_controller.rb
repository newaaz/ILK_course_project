class Customers::DashboardController < ApplicationController
  before_action :authorize_dashboard!
  after_action  :verify_authorized

  def index
  end

  private

  def pundit_user
    current_customer
  end

  def authorize_dashboard!
    authorize([:customers, :dashboard])
  end
end
