class PartnerPolicy < ApplicationPolicy
  def destroy?
    record == user
  end
end