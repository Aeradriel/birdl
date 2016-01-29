module Events
  # Controller for online chat
  class GroupEventController < ApplicationController
    include EventsHelper

    before_action :set_event, only: [:show, :edit, :update,
                                     :destroy, :register]

    def index
      @past_events = current_user.events.past
      @future_events = current_user.events.future
    end

    def register
      if can_register?(@event, current_user)
        @event.users << current_user
        if @event.save
          badge1 = Badge.where(identifier: 'badge_course_name').first
          badge2 = Badge.where(identifier: 'badge_marathon_name').first
          badge3 = Badge.where(identifier: 'badge_ironman_name').first
          if badge1 && @current_user.events.count == 1
            Achievement.create(badge_id: badge1.id, user_id: @current_user.id, progression: 100)
            Notification.create(user_id: @event.owner.id, subject:'Nouveau badge !', text: "Vous avez reçu le badge \"#{badge1.name}\"")
          end
          if badge2 && @current_user.events.count == 20
            Achievement.create(badge_id: badge2.id, user_id: @current_user.id, progression: 100)
            Notification.create(user_id: @event.owner.id, subject:'Nouveau badge !', text: "Vous avez reçu le badge \"#{badge2.name}\"")
          end
          if badge3 && @current_user.events.count == 75
            Achievement.create(badge_id: badge3.id, user_id: @current_user.id, progression: 100)
            Notification.create(user_id: @event.owner.id, subject:'Nouveau badge !', text: "Vous avez reçu le badge \"#{badge3.name}\"")
          end
          Notification.create(user_id: @event.owner.id, subject:'Nouveau participant !', text: "#{@current_user.name} a rejoint votre événement \"#{@event.name}\"")
          redirect_to action: 'show', notice: 'Vous êtes maintenant inscrit à cet événement'
        else
          redirect_to action: 'show', alert: 'Une erreur est survenue lors de votre inscription.'\
          'Veuillez ressayer sous peu'
        end
      else
        redirect_to action: 'show', alert: 'Vous êtes déjà inscrit à cet événement ou celui-ci'\
        'est complet'
      end
    end

    def show
      @user_events = []
      Event.all.each do |e|
        if e.date > Time.now && (e.owner.id == current_user.id || current_user.events.include?(e))
          @user_events << e
        end
      end
      @user_events.sort! { |a, b| a.date <=> b.date }

      @event_users = @event.users
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end
  end
end
