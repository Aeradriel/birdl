# Helpers for users module
module UserHelper
  def user_is_valid(user)
    user && user.valid? && user.confirm
  end

  def user_is_event_owner(user, event)
    event.owner.id == user.id || event.type == 'FaceToFace'
  end

  def can_rate_user_for_event(user, event)
    return false unless event.users.include(user) && event.users.include(current_user)
    return false unless user_is_event_owner(user, event)
    current_user.given_ratings.each do |g_r|
      return false if g_r.user.id == user.id && g_r.event.id == event.id
    end
    true
  end
end
