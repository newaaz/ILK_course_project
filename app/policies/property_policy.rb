class PropertyPolicy < ApplicationPolicy
  # only admin can index (then - remove index)
  def index?
    user.admin?
  end
  
  def show?
    true
  end
  
  def create?
    user.is_a?(Owner)
  end

  def update?
    user == record.owner || user.admin?
  end

  def destroy?
    user == record.owner || user.admin?
  end
  
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
