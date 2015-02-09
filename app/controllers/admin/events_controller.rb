module Admin
  # Controller for events admin panel
  class EventsController < AdminController
    before_action :actual_event, only: [:new, :edit, :update, :destroy]

    def index
      @events = Event.order(:name).page(params[:page])
    end

    def new
      @event = Event.new
      @event_types =
          [
              [t(:face_to_face), 'FaceToFace'],
              [t(:online_chat), 'OnlineChat'],
              [t(:tourism_tour), 'TourismTour']
          ]
      render :new_event
    end

    def create
      e = Event.new(event_params)

      if e.save
        flash[:notice] = "L'événement #{e.name} a bien été creé"
      else
        flash[:alert] = "L'événement #{e.name} n'a pas pu être créé : #{e.errors.inspect}"
      end
      redirect_to action: :index
    end

    def edit
      @event_types =
          [
              [t(:face_to_face), 'FaceToFace'],
              [t(:online_chat), 'OnlineChat'],
              [t(:tourism_tour), 'TourismTour']
          ]
      render :edit_event
    end

    def update
      if @event.update(event_params)
        flash[:notice] = "L'événement #{@event.name} a bien été modifié"
      else
        flash[:alert] = "L'événement #{@event.name} n'a pas pu être modifié"
      end
      redirect_to action: :index
    end

    def destroy
      name = @event.name

      if @event.destroy
        flash[:notice] = "L'événement #{name} a bien été supprimé"
      else
        flash[:alert] = "L'événement #{name} n'a pas pu être supprimé"
      end
      redirect_to action: :index
    end

    private

    def event_params
      if actual_event.class == FaceToFace
        params.require(:face_to_face).permit(:name, :type,:min_slots,
                                             :max_slots, :date, :end)
      elsif actual_event.class == OnlineChat
        params.require(:online_chat).permit(:name, :type,:min_slots,
                                            :max_slots, :date, :end)
      elsif actual_event.class == TourismTour
        params.require(:tourism_tour).permit(:name, :type,:min_slots,
                                             :max_slots, :date, :end)
      else
        params.require(:event).permit(:name, :type,:min_slots,
                                      :max_slots, :date, :end)
      end
    end

    def actual_event
      @event = Event.find(params[:event_id]) if params[:event_id]
    end
  end
end
