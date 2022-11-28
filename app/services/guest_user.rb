class GuestUser
  def guest?
    true
  end

  def admin?
    false
  end

  def id
    'guest_id'
  end
end
