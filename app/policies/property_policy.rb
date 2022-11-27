class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
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
end
