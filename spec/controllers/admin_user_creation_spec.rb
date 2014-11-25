require 'spec_helper'
require 'rails_helper'

describe 'The admin user creation page' do
  def sign_in(user)
    user.confirm!
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @country = Country.create!(name: 'France', language: 'Français',
                               flag_path: 'public/flags/french.jpg')
    @user = User.create!(first_name: 'Thibaut', last_name: 'Roche',
                         birthdate: Date.new(1994, 02, 11),
                         gender: 1, email: 'thibaut.roche.perso@gmail.com',
                         password: 'liodzojdzol',
                         password_confirmation: 'liodzojdzol', admin: true,
                         country: Country.first, confirmed_at: Date.current)

    sign_in @user
    visit '/admin/users/new'
  end
end
