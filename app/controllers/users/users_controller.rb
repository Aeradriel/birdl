module Users
  # Controller for users
  class UsersController < ApplicationController
    before_action :set_user

    def rate
      @common_events = Event.all
      @common_events.reject do |e|
        e.users.include(current_user) && e.users.include(@user)
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end
  end
end
