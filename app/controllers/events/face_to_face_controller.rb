module Events
  # Controller for GroupEvent
  class FaceToFaceController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update,
                                     :destroy]

    def index
      @events = Event.all
      render :search
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
