module Users
  # Controller for users
  class UsersController < ApplicationController
    before_action :set_user

    def rate
    end

    private

    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end
  end
end
