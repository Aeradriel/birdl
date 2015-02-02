module Admin
  # Controller for events admin panel
  class EventsController < AdminController
    before_action :actual_event

    def index
      @events = Event.order(:name).page(params[:page])
    end

    def new
      @event = Event.new
      render :new_event
    end

    def create
      e = event.new(event_params)

      if e.save
        flash[:notice] = "L'événement #{e.name} a bien été creé"
      else
        flash[:alert] = "L'événement #{e.name} n'a pas pu être créé"
      end
      redirect_to action: :events
    end

    def edit
      render :edit_event
    end

    def update
      if @event.update(parameters)
        flash[:notice] = "L'événement #{@event.name} a bien été modifié"
      else
        flash[:alert] = "L'événement #{@event.name} n'a pas pu être modifié"
      end
      redirect_to action: :events
    end

    def delete
      name = @event.name

      if @country.destroy
        flash[:notice] = "L'événement #{name} a bien été supprimé"
      else
        flash[:alert] = "L'événement #{name} n'a pas pu être supprimé"
      end
      redirect_to action: :events
    end

    private

    def event_params
      params.require(:event).permit(:name, :min_slots, :max_slots,
      :date, :end)
    end

    def actual_event
      @event = Event.find(params[:event_id]) if params[:event_id]
    end
  end
end
