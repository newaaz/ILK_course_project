class BookingPolicy < ApplicationPolicy
  def create?
    record.activated?
  end
end
