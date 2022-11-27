class Owners::DashboardPolicy < ApplicationPolicy  
  def index?
    user.is_a?(Owner)
  end  
end
