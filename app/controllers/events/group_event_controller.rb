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
