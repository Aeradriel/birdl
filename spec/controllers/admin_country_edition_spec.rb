require 'spec_helper'
require 'rails_helper'

describe 'The admin country edition page' do
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
    visit "/admin/countries/#{@country.id}/edit"
  end

  it 'should change name when filling the name' do
    fill_in 'country_name', with: 'England'
    click_button 'edit_submit'
    expect(Country.find(@country.id).name).to eq 'England'
  end

  it 'should change language when filling the name' do
    fill_in 'country_language', with: 'English'
    click_button 'edit_submit'
    expect(Country.find(@country.id).language).to eq 'English'
  end

  it 'should change flag path when upload a correct image' do
    pending 'Waiting for test implementation'
    file = fixture_file_upload('files/imagefile.png', 'image/png')
    post :update_country, upload: file
    click_button 'edit_submit'
    expect(Country.find(@country.id).flag_path).to eq 'lolilol'
  end
end
