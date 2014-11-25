require 'spec_helper'
require 'rails_helper'

describe 'The menu' do
  describe 'if not logged' do
    before :each do
      visit '/login'
    end

    it 'should display a sign up link' do
      expect(page).to have_css('#signup_link')
    end

    it 'should display a sign in link' do
      expect(page).to have_css('#signin_link')
    end
  end

  describe 'if logged' do
    def sign_in(user)
      user.confirm!
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'login_submit'
    end

    before :each do
      Country.create(name: 'France', language: 'Français',
                     flag_path: 'public/flags/french.jpg')
      @user = User.create!(first_name: 'Thibaut', last_name: 'Roche',
                           birthdate: Date.new(1994, 02, 11),
                           gender: 1, email: 'thibaut.roche.perso@gmail.com',
                           password: 'liodzojdzol',
                           password_confirmation: 'liodzojdzol',
                           country: Country.first, confirmed_at: Date.current)

      visit '/login'
      sign_in @user
    end

    it 'should display a profile link' do
      expect(page).to have_css('#profile_link')
    end

    it 'should display a logout link' do
      expect(page).to have_css('#logout_link')
    end

    describe 'for simple user' do
      it 'should not display an admin link' do
        expect(page).to_not have_css('#admin_link')
      end
    end

    describe 'for admin' do
      before :each do
        @user.admin = true
        @user.save

        visit '/'
      end

      it 'should display an admin link' do
        expect(page).to have_css('#admin_link')
      end
    end
  end
end
