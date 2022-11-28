class ActiveStorage::AttachmentPolicy < ApplicationPolicy
  def purge?
    record.record.owner_id == user.id || user.admin?
  end
end
