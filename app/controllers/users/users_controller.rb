module Users
  # Controller for users
  class UsersController < ApplicationController
    include UserHelper
    before_action :set_user

    def show
      @common_events = Event.all
      @common_events.reject do |e|
        e.users.include?(current_user) && e.users.include?(@user)
      end
    end

    def get_rate
      @event = User.where(id: params[:event_id].to_i).first
    end

    def rate
      u = User.where(id: params[:user_id].to_i).first
      e = Event.where(id: params[:event_id].to_i).first
      val = { 1 => 5, 2 => 4, 3 => 3, 4 => 2, 5 => 1}
      v = val[params['rating-input-1'].to_i]
      if u && e && v
        if can_rate_user_for_event(u, e)
          r = UserRating.new(user_id: u.id, giver_id: current_user.id, value: v, event_id: e.id)
          if r.save
            flash[:notice] = 'Votre vote a été bien été pris en compte.'
          else
            flash[:alert] = 'Une erreur est survenue. Veuillez ressayer dans quelques instants.'
          end
          redirect_to "/events/groupevents/#{params[:event_id]}", notice: "Vous avez bien noté #{u.name}"
        end
      else
        redirecft_to "/events/groupevents/#{params[:event_id]}", notice: "Un erreur est survenue lors de la notation"
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end
  end
end
