class Partner::DashboardPolicy < ApplicationPolicy  
  def index?
    user.is_a?(Partner)
  end  
end
