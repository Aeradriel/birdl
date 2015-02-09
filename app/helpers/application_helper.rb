# Helpers for application module
module ApplicationHelper
  def admin_controller?
    controller = controller_path.split('/').first

    true if controller == 'admin'
  end
end
