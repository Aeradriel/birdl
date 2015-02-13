# Base controller
class ApplicationController < ActionController::Base
  include I18nHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :check_auth
  before_action :devise_permitted_parameters, if: :devise_controller?

  def change_locale
    if current_user
      current_user.update(locale: params[:key])
    else
      I18n.locale = params[:key]
      cookies[:locale] = params[:key]
    end
    redirect_to :back
  end

  protected

  def set_locale
    if current_user_locale
      I18n.locale = current_user_locale
    elsif browser_language
      I18n.locale = browser_language unless cookies[:locale]
    end
  end

  def check_auth
    authorized = %w(application sessions registrations confirmations
                    passwords omniauth_callbacks)
    return unless !user_signed_in? && !authorized.include?(controller_name)
    flash[:alert] = t('devise.failure.unauthenticated')
    redirect_to new_user_session_path
  end

  def after_sign_out_path_for(_)
    new_user_session_path
  end

  def devise_permitted_parameters
    registration_params = [:first_name, :last_name, :birthdate, :country_id,
                           :gender, :email, :password, :password_confirmation]

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(registration_params << :current_password)
    end
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(registration_params)
    end
  end
end
