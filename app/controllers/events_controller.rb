# Controller for Events
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event), notice: 'Event was successfully created.'
    else
      redirect_to events_path, danger: 'Event error'
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
                                  :max_slots, :date, :end)
  end
end
