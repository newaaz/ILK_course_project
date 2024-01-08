class Partners::DashboardPolicy < ApplicationPolicy  
  def index?
    user.is_a?(Partner)
  end
  
  def orders?
    user.is_a?(Partner)
  end

  def profile?
    user.is_a?(Partner)
  end

  def add_listing?
    user.is_a?(Partner)
  end

  def bookings?
    user.is_a?(Partner)
  end

  def info?
    user.is_a?(Partner)
  end

  def cancel_mailing?
    user.is_a?(Partner)
  end
end
