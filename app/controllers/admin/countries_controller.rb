module Admin
  # Controller for country admin panel
  class CountriesController < AdminController
    before_action :actual_country

    def countries
      @countries = Country.order(:name).page(params[:page])
    end

    def new
      @country = Country.new
      render :new_country
    end

    def create
      parameters = country_params
      flag_path = params[:country][:flag_path]
      save_flag(parameters, flag_path) if flag_path
      c = Country.create(parameters)
      c.available = params[:country][:available] == '0' ? false : true

      if c.save
        flash[:notice] = 'Le pays a bien été creé.'
      else
        flash[:alert] = "Le pays n'a pas pu être créé." \
        " #{c.errors.messages}"
      end
      redirect_to action: :countries
    end

    def edit
      render :edit_country
    end

    def update
      parameters = country_params
      flag_path = params[:country][:flag_path]
      save_flag(parameters, flag_path) if flag_path
      @country.available = params[:country][:available] == '0' ? false : true

      if @country.update(parameters)
        flash[:notice] = 'Le pays a bien été modifié.'
      else
        flash[:alert] = "Le pays n'a pas pu être modifié" \
        "#{@country.errors.messages}"
      end
      redirect_to action: :countries
    end

    def delete
      name = @country.language

      if @country.destroy
        flash[:notice] = "Le pays #{name} a bien été supprimé."
      else
        flash[:alert] = "Le pays #{name} n'a pas pu être supprimé." \
        "#{@country.errors.messages}"
      end
      redirect_to action: :countries
    end

    private

    def country_params
      params[:country].delete(:flag_path) if params[:country][:flag_path].nil?
      params.require(:country).permit(:name, :language, :flag_path, :i18n_key)
    end

    def actual_country
      @country = Country.find(params[:country_id]) if params[:country_id]
    end
  end
end
