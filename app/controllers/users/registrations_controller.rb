module Users
  # Override of user update method
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_update_path_for(_)
      '/users/edit'
    end

    def update_resource(resource, _)
      if resource.fb_acc
        params[:user].delete(:current_password)
        resource.update_without_password(account_update_params)
      else
        resource.update_with_password(account_update_params)
      end
    end

    private

    def account_update_params
      devise_parameter_sanitizer.sanitize(:account_update)
    end
  end
end
