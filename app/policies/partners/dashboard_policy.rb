class Partners::DashboardPolicy < ApplicationPolicy  
  def index?
    user.is_a?(Partner)
  end
  
  def orders?
    user.is_a?(Partner)
  end
end
