class OrderPolicy < ApplicationPolicy
  def new?
    user.is_a?(Customer)
  end

  def create?
    user.is_a?(Customer)
  end

  def pay_order?
    record.customer == user || record.status == 'accepted'
  end

  def accept_order?
    record.property.owner == user || record.status == 'received'
  end

  def reject_order?
    record.property.owner == user || record.status == 'received'
  end

  def show?
    (record.property.owner == user) || record.customer == user
  end
end
