# Helpers for users module
module UserHelper
  def user_is_valid(user)
    user && user.valid? && user.confirm!
  end
end
