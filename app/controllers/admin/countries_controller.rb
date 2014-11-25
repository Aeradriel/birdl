module Admin
  # Controller for country admin panel
  class CountriesController < ApplicationController
    before_action :check_auth, :actual_country
    layout 'admin_menu'

    def check_auth
      return unless !user_signed_in? || !current_user.admin
      flash[:alert] = t('devise.failure.unauthenticated')
      redirect_to new_user_session_path
    end

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

      if c && c.valid?
        flash[:notice] = "Le pays #{c.name} a bien été creé"
      else
        flash[:alert] = "Le pays #{c.name} n'a pas pu être créé"
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

      if @country.update(parameters) && @country.valid?
        flash[:notice] = "Le pays #{@country.name} a bien été modifié"
      else
        flash[:alert] = "Le pays #{@country.name} n'a pas pu être modifié"
      end
      redirect_to action: :countries
    end

    def delete
      name = @country.language

      if @country.destroy
        flash[:notice] = "Le pays #{name} a bien été supprimé"
      else
        flash[:alert] = "Le pays #{name} n'a pas pu être supprimé"
      end
      redirect_to action: :countries
    end

    private

    def country_params
      params[:country].delete(:flag_path) if params[:country][:flag_path].nil?
      params.require(:country).permit(:name, :language, :flag_path)
    end

    def actual_country
      @country = Country.find(params[:country_id]) if params[:country_id]
    end
  end
end
