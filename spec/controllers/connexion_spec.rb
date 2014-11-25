require 'spec_helper'
require 'rails_helper'

describe 'The connexion page' do
  before :each do
    Country.create(name: 'France', language: 'Français',
                   flag_path: 'public/flags/french.jpg')
    @good_user = User.create!(first_name: 'Thibaut', last_name: 'Roche',
                              birthdate: Date.new(1994, 02, 11),
                              gender: 1, email: 'thibaut.roche.perso@gmail.com',
                              password: 'liodzojdzol',
                              password_confirmation: 'liodzojdzol',
                              country: Country.first,
                              confirmed_at: Date.current)
    @user_not_validated = User.create!(first_name: 'Thibaut',
                                       last_name: 'Roche',
                                       birthdate: Date.new(1994, 02, 11),
                                       gender: 1,
                                       email: 'thibaut.roche.perso2@gmail.com',
                                       password: 'liodzojdzol',
                                       password_confirmation: 'liodzojdzol',
                                       country: Country.first)
    visit '/login'
  end

  it 'should raise an error for bad ids' do
    within '#new_user' do
      fill_in 'user_email', with: 'lol@lol.lol'
      fill_in 'user_password', with: 'lol'
      click_on I18n.t(:sign_in)
    end
    expect(page).to have_css('.alert-danger')
  end

  it 'should raise an error for bad password' do
    within '#new_user' do
      fill_in 'user_email', with: @good_user.email
      fill_in 'user_password', with: 'lol'
      click_on I18n.t(:sign_in)
    end
    expect(page).to have_css('.alert-danger')
  end

  it 'should not allow login with unconfirmed address' do
    within '#new_user' do
      fill_in 'user_email', with: @user_not_validated
      fill_in 'user_password', with: 'liodzojdzol'
      click_on I18n.t(:sign_in)
    end
    expect(page).to have_css('.alert-danger')
  end

  it 'should allow login with good ids' do
    within '#new_user' do
      fill_in 'user_email', with: @good_user.email
      fill_in 'user_password', with: 'liodzojdzol'
      click_on I18n.t(:sign_in)
    end
    expect(page).to_not have_css('.alert-danger')
  end
end
