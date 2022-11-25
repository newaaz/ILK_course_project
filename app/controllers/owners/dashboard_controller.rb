class Owners::DashboardController < ApplicationController
  before_action :authenticate_owner!

  def index
  	@properties = current_owner.properties
  end

  def main
    @properties = current_owner.properties
  end
end