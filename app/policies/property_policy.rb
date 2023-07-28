class PropertyPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.activated? ||user == record.owner || user.admin?
  end
  
  def create?
    user.is_a?(Partner)
  end

  def update?
    user == record.owner
  end

  def destroy?
    user == record.owner
  end

  def calculate_price?
    true
  end
end
