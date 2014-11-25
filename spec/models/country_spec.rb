require 'spec_helper'
require 'rails_helper'

describe 'A Country' do
  before :each do
    @country = Country.create!(name: 'France', language: 'Français',
                               flag_path: 'public/flags/french.jpg',
                               available: false, i18n_key: nil)
  end

  it 'should have the correct name' do
    expect(@country.valid?).to eq true
    expect(@country.name).to eq 'France'
  end

  it 'should have the correct language' do
    expect(@country.valid?).to eq true
    expect(@country.language).to eq 'Français'
  end

  it 'should have the correct flag path' do
    expect(@country.valid?).to eq true
    expect(@country.flag_path).to eq 'public/flags/french.jpg'
  end

  it 'should not have an empty language' do
    bad_country = Country.new(name: 'France', language: '',
                              flag_path: 'public/flags/french.jpg')
    expect(bad_country.valid?).to eq false
  end

  it 'should not be valid without language' do
    bad_country = Country.new(name: 'France',
                              flag_path: 'public/flags/french.jpg')
    expect(bad_country.valid?).to eq false
  end

  it 'should not have an empty name' do
    bad_country = Country.new(name: '', language: 'Français',
                              flag_path: 'public/flags/french.jpg')
    expect(bad_country.valid?).to eq false
  end

  it 'should not be valid without name' do
    bad_country = Country.new(flag_path: 'public/flags/french.jpg')
    expect(bad_country.valid?).to eq false
  end

  it 'when deleted should reset its users country' do
    User.create!(id: 1, first_name: 'Thibaut', last_name: 'Roche',
                 birthdate: Date.new(1994, 02, 11),
                 gender: 1, email: 'thibaut.roche.perso@gmail.com',
                 password: 'liodzojdzol',
                 password_confirmation: 'liodzojdzol',
                 country: Country.first)
    User.create!(id: 2, first_name: 'Thibaut', last_name: 'Roche',
                 birthdate: Date.new(1994, 02, 11),
                 gender: 1, email: 'thibaut.roche.perso2@gmail.com',
                 password: 'liodzojdzol',
                 password_confirmation: 'liodzojdzol',
                 country: Country.first)
    User.create!(id: 3, first_name: 'Thibaut', last_name: 'Roche',
                 birthdate: Date.new(1994, 02, 11),
                 gender: 1, email: 'thibaut.roche.perso3@gmail.com',
                 password: 'liodzojdzol',
                 password_confirmation: 'liodzojdzol',
                 country: Country.first)

    @country.destroy
    expect(User.find(1).country).to eq nil
    expect(User.find(2).country).to eq nil
    expect(User.find(3).country).to eq nil
  end

  it 'should not be valid when available without i18n key' do
    @country.available = true
    expect(@country.valid?).to eq false
  end

  it 'should be valid when available with a i18n key' do
    @country.available = true
    @country.i18n_key = :fr
    expect(@country.valid?).to eq true
  end
end
