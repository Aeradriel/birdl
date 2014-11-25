require 'spec_helper'
require 'rails_helper'

describe 'The admin account edition page' do
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
    visit "/admin/users/#{@user.id}/edit"
  end

  it 'should change address when filling the email form' do
    fill_in 'user_email', with: 'bonjour@lol.com'
    click_button 'edit_submit'
    expect(User.find(@user.id).email).to eq 'bonjour@lol.com'
  end

  it 'should change first name when editing in form' do
    fill_in 'user_first_name', with: 'Nouveau nom'
    click_button 'edit_submit'
    expect(User.find(@user.id).first_name).to eq 'Nouveau nom'
  end

  it 'should change last name when editing in form' do
    fill_in 'user_last_name', with: 'Nouveau nom'
    click_button 'edit_submit'
    expect(User.find(@user.id).last_name).to eq 'Nouveau nom'
  end

  it 'should change gender when editing in form' do
    select 'Femme', from: 'user_gender'
    click_button 'edit_submit'
    expect(User.find(@user.id).gender).to eq 0
  end

  it 'should change country when editing in form' do
    @country2 = Country.create!(name: 'USA', language: 'English (US)',
                                flag_path: 'public/flags/french.jpg')
    @country3 = Country.create!(name: 'England', language: 'English (GB)',
                                flag_path: 'public/flags/french.jpg')
    @country4 = Country.create!(name: 'Spain', language: 'Spanish',
                                flag_path: 'public/flags/french.jpg')

    visit "/admin/users/#{@user.id}/edit"
    select 'England', from: 'user_country_id'
    click_button 'edit_submit'
    user = User.find(@user.id).country
    expect(user).to eq Country.where(name: 'England').first
  end

  it 'should change password when editing correctly it and its confirmation' do
    fill_in 'user_password', with: 'jemappelleguy'
    click_button 'edit_submit'
    expect(User.find(@user.id).valid_password?('jemappelleguy')).to eq true
  end
end
