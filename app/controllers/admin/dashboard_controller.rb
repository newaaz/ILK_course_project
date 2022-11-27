class Admin::DashboardController < Admin::BaseController
  before_action :authorize_dashboard!
  after_action  :verify_authorized

  def index  
  end

  private

  def pundit_user
    current_owner
  end

  def authorize_dashboard!
    authorize(:dashboard)
  end
end
