class RoomPolicy < ApplicationPolicy
  def show?
    true
  end
  
  def create?
    record.property.owner_id == user.id || user.admin?
  end

  def update?
    record.property.owner_id == user.id || user.admin?
  end

  def destroy?
    record.property.owner_id == user.id || user.admin?
  end
end
