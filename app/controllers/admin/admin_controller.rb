module Admin
  # Controller for admin panel
  class AdminController < ApplicationController
    include AdminHelper

    before_action :check_auth
    layout 'admin_menu'

    def check_auth
      return unless !user_signed_in? || !current_user.admin
      flash[:alert] = t('devise.failure.unauthenticated')
      redirect_to new_user_session_path
    end

    def index
      @group_languages = languages_datas
      @group_genders = genders_datas
    end

    def ut_report
      render :report
    end

    def ut_coverage
      render '/coverage/index'
    end
  end
end
