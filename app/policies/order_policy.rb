class OrderPolicy < ApplicationPolicy
  def show?
    (user.is_a?(Customer) && record.customer_id == user.id) ||
    (user.is_a?(Owner) && record.property.owner_id == user.id) ||
    user.admin?
  end

  def new?
    user.is_a?(Customer)
  end

  def create?
    user.is_a?(Customer) && record.property.rooms.ids.include?(record.room_id)
  end
end
