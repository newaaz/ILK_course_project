class OrderPolicy < ApplicationPolicy
  def new?
    user.is_a?(Customer)
  end

  def create?
    user.is_a?(Customer)
  end
end
