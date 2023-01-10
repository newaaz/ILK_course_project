class OrderPolicy < ApplicationPolicy
  def new?
    user.is_a?(Customer)
  end

  def create?
    user.is_a?(Customer)
  end

  def accept_order?
    record.property.owner == user
  end

  def reject_order?
    record.property.owner == user
  end



end
