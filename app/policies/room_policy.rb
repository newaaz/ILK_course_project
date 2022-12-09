class RoomPolicy < ApplicationPolicy
  def create?
    record.property.owner_id == user.id
  end

  def update?
    record.property.owner_id == user.id
  end

  def destroy?
    record.property.owner_id == user.id
  end
end
