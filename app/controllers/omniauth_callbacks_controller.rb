# Callbacks for Omniauth
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    puts "DEBUG : #{request.env['omniauth.auth']}"
    sign_in @user
    flash[:notice] = t('devise.sessions.signed_in')
    redirect_to root_path
  end
end
