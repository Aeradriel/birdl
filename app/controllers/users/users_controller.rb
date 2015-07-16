module Users
  # Controller for users
  class UsersController < ApplicationController
    before_action :set_user

    def rate
      @common_events = Event.all.to_a
      @common_events.each do |e|
        @common_events.delete(e) unless e.users.include?(@user) && e.users.include?(current_user)
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end
  end
end
