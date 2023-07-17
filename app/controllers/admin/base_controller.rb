class Admin::BaseController < ApplicationController
  #layout 'admin'

  before_action :authorize_admin_dashboard!
  after_action  :verify_authorized

  private

  def pundit_user
    current_partner
  end

  def authorize_admin_dashboard!
    authorize([:admin, :dashboard], :index?)
  end
end
