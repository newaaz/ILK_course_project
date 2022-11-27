class Customers::DashboardPolicy < ApplicationPolicy  
  def index?
    user.is_a?(Customer)
  end  
end

