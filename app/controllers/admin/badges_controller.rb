module Admin
  # Controller for badges admin panel
  class BadgesController < AdminController
    before_action :actual_badge

    def badges
      @badges = Badge.order(:id).page(params[:page])
    end

    def new
      @badge = Badge.new
      render :new_badge
    end

    def create
      parameters = badge_params
      icon_path = params[:badge][:icon_path]
      save_badge_icon(parameters, icon_path) if icon_path
      b = Badge.new(parameters)

      if b.save
        flash[:notice] = 'Le badge a bien été creé.'
      else
        flash[:alert] = "Le badge n'a pas pu être créé." \
        " #{b.errors.messages}"
      end
      redirect_to action: :badges
    end

    def edit
      render :edit_badge
    end

    def update
      parameters = badge_params
      icon_path = params[:badge][:icon_path]
      save_badge_icon(parameters, icon_path) if icon_path

      if @badge.update(parameters)
        flash[:notice] = 'Le badge a bien été modifié.'
      else
        flash[:alert] = "Le badge n'a pas pu être modifié" \
        "#{@badge.errors.messages}"
      end
      redirect_to action: :badges
    end

    def delete
      name = @badge.name

      if @badge.destroy
        flash[:notice] = "Le pays #{name} a bien été supprimé."
      else
        flash[:alert] = "Le pays #{name} n'a pas pu être supprimé." \
        "#{@badge.errors.messages}"
      end
      redirect_to action: :badges
    end

    private

    def badge_params
      params[:badge].delete(:icon_path) if params[:badge][:icon_path].nil?
      params.require(:badge).permit(:name, :identifier, :description, :icon_path)
    end

    def actual_badge
      @badge = Badge.find(params[:badge_id]) if params[:badge_id]
    end
  end
end
