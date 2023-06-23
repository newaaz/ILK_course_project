class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    true
  end
  
  def show?
    true
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
