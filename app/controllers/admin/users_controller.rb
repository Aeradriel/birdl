module Admin
  # Controller for users admin panel
  class UsersController < ApplicationController
    include UserHelper

    before_action :check_auth, :actual_user

    def check_auth
      return if user_signed_in? && current_user.admin
      flash[:alert] = t('devise.failure.unauthenticated')
      redirect_to new_user_session_path
    end

    def users
      @users = User.normals.page(params[:users_page])
      @admins = User.admins.page(params[:admins_page])
    end

    def new
      @user = User.new
      render :new_user
    end

    def create
      user = User.new(user_params)

      if user.save
        flash[:notice] = "L'utilisateur #{user.name} a bien été creé"
      else
        flash[:alert] = "L'utilisateur n'a pas pu être créé"
      end
      redirect_to action: :users
    end

    def edit
      render :edit_user
    end

    def update
      if @user.update(user_params) && @user.confirm!
        flash[:notice] = "L'utilisateur #{@user.name} a bien été mis à jour"
      else
        flash[:alert] = "L'utilisateur #{@user.name} n'a pas pu être mis à jour"
      end
      redirect_to action: :users
    end

    def delete
      name = @user.name

      if @user.destroy
        flash[:notice] = "L'utilisateur #{name} a bien été supprimé"
      else
        flash[:alert] = "L'utilisateur #{name} n'a pas pu être supprimé"
      end
      redirect_to action: :users
    end

    private

    def user_params
      params[:user].delete(:password) if params[:user][:password].blank?
      params.require(:user).permit!
    end

    def actual_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end
  end
end
