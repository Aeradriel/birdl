# Controller for information checking about users
class InformationCheckerController < ApplicationController
  before_action :set_date, only: :check_birthdate

  def validate_birthdate
    render :check_birthdate
  end

  def check_birthdate
    check_referer
    if @date > 18.years.ago
      flash[:alert] = t(:to_young)
      redirect_to :new_user_session_path
    end
    if current_user.update(birthdate: @date)
      redirect_to root_path, notice: t(:birthdate_validation_success)
    else
      redirect_to root_path, alert: t(:birthdate_validation_fail)
    end
  end

  private

  def check_referer
    referer = Rails.application.routes.recognize_path(request.referrer)
    redirect_to new_user_session_path unless
        referer[:controller] == controller_name
  end

  def set_date
    @date = Date.strptime(params[:birthdate], '%Y-%m-%d')
  end
end
