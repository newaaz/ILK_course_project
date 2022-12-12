class ActiveStorage::AttachmentPolicy < ApplicationPolicy
  def purge?
    if record.record.is_a?(Room)
      record.record.property.owner_id == user.id
    else
      record.record.owner_id == user.id
    end
  end
end
