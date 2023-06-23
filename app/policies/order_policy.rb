class OrderPolicy < ApplicationPolicy
  def show?
    (record.property.owner == user) || record.customer == user
  end
  
  def new?
    #user.is_a?(Customer)
    true
  end

  def create?
    #user.is_a?(Customer)
    true
  end

  def pay_order?
    record.customer == user && record.status == 'accepted'
  end

  def accept_order?
    record.property.owner == user && record.status == 'received'
  end

  def reject_order?
    record.property.owner == user && record.status == 'received'
  end
end
