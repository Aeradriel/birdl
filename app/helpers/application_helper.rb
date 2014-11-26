# Helpers for application module
module ApplicationHelper
  def admin_controller?
    admin_controllers = %w(users countries admin)

    true if admin_controllers.include?(controller_name)
  end
end
