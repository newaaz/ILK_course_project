class ImagesPolicy < ApplicationPolicy
  def destroy?
    record.owner == user
  end
end

