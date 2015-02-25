# Callbacks for Omniauth
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.confirm! if @user.confirmed? == false
    sign_in @user
    flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                            kind: 'Facebook')
    redirect_to root_path
  end

  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.confirm! if @user.confirmed? == false
    puts @user.inspect
    sign_in @user
    flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                            kind: 'Google')
    redirect_to root_path
  end
end
