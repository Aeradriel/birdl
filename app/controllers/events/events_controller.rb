module Events
  # Controller for Events
  class EventsController < ApplicationController
    include EventsHelper

    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # GET /events
    # GET /events.json
    def search
      @event_types =
          [
            ['Non renseigné', 'none'],
            [t(:face_to_face), 'FaceToFace'],
            [t(:online_chat), 'OnlineChat'],
            [t(:tourism_tour), 'TourismTour'],
            [t(:group_event), 'GroupEvent']
          ]
    end

    def search_result
      @events = Event.where('name LIKE ?', "%#{params[:searchterm]}%")

      @events.each do |e|
        @events.delete(e) if e.remaining_slots < params[:remaining_slots].to_i
      end
      @events = params[:past_events] == 'true' ? @events.past : @events.future
      @events = @events.where(type: params[:event_type]) if
          params[:event_type] != 'none'
    end

    # GET /events/1
    # GET /events/1.json
    def show
    end

    # GET /events/new
    def new
      @event = Event.new
      @event_types =
          [
            [t(:face_to_face), 'FaceToFace'],
            [t(:online_chat), 'OnlineChat'],
            [t(:tourism_tour), 'TourismTour'],
            [t(:group_event), 'GroupEvent']
          ]
    end

    # GET /events/1/edit
    def edit
    end

    # POST /events
    # POST /events.json
    def create
      @event = Event.new(event_params)
      @address = Address.new(event_address_params)
      @event.owner_id = current_user.id
      @event.address = @address

      if @address.save && @event.save
        redirect_to event_route(@event)
        flash[:notice] = 'Event was successfully created.'
      else
        redirect_to events_path, alert: @event.errors.messages
      end
    end

    # PATCH/PUT /events/1
    # PATCH/PUT /events/1.json
    def update
      if @event.update(event_params)
        redirect_to event_path(@event),
                    notice: 'Event was successfully updated.'
      else
        redirect_to event_path(@event), danger: 'Event error'
      end
    end

    # DELETE /events/1
    # DELETE /events/1.json
    def destroy
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :type, :min_slots,
                                    :max_slots, :date, :end,
                                    :address, :language)
    end

    def event_address_params
      params.require(:event).require(:address_attributes)
        .permit(:num, :street, :zipcode,
                :city, :country_id)
    end
  end
end
