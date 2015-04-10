module Events
  # Controller for online chat
  class GroupEventController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update,
                                     :destroy]

    def index
      @past_events = current_user.events.past
      @future_events = current_user.events.future
    end

    def show
    end

    def new
    end

    def create
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
