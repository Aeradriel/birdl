require 'spec_helper'
require 'rails_helper'

describe 'A User' do
  before :each do
    Country.create(name: 'France', language: 'Français',
                   flag_path: 'public/flags/french.jpg')
    @birthdate = Date.new(1994, 02, 11)
    @valid_user = User.create!(first_name: 'Thibaut', last_name: 'Roche',
                               birthdate: @birthdate, gender: 1,
                               email: 'thibaut.roche.perso@gmail.com',
                               password: 'liodzojdzol',
                               password_confirmation: 'liodzojdzol',
                               country: Country.first)
  end

  it 'should have a first name' do
    expect(@valid_user.valid?).to eq true
    expect(@valid_user.first_name).to eq 'Thibaut'
  end

  it 'should have a non-blank first name' do
    invalid_user = User.create(first_name: '', last_name: 'Roche',
                               birthdate: @birthdate, gender: 1,
                               email: 'thibaut.roche.perso2@gmail.com',
                               password: 'liodzojdzol',
                               password_confirmation: 'liodzojdzol',
                               country: Country.first)

    expect(invalid_user.valid?).to eq false
  end

  it 'should have a last name' do
    expect(@valid_user.valid?).to eq true
    expect(@valid_user.last_name).to eq 'Roche'
  end

  it 'should have a non-blank last name' do
    invalid_user = User.create(first_name: 'Thibaut', last_name: '',
                               birthdate: @birthdate, gender: 1,
                               email: 'thibaut.roche.perso2@gmail.com',
                               password: 'liodzojdzol',
                               password_confirmation: 'liodzojdzol',
                               country: Country.first)

    expect(invalid_user.valid?).to eq false
  end

  it 'should have a gender' do
    expect(@valid_user.valid?).to eq true
    expect(@valid_user.gender).to eq 1
  end

  it 'should have a valid gender' do
    invalid_user = User.create(first_name: 'Thibaut', last_name: 'Roche',
                               birthdate: @birthdate, gender: 1,
                               email: 'thibaut.roche.perso2@gmail.com',
                               password: 'liodzojdzol',
                               password_confirmation: 'liodzojdzol',
                               country: Country.first)

    1000.times do
      invalid_user.gender = rand(-100..100)
      if invalid_user.gender == 1 || invalid_user.gender == 0
        expect(invalid_user.valid?).to eq true
      else
        expect(invalid_user.valid?).to eq false
      end
    end
  end

  it 'should have an email' do
    expect(@valid_user.valid?).to eq true
    expect(@valid_user.email).to eq 'thibaut.roche.perso@gmail.com'
  end

  it 'should not be admin' do
    expect(@valid_user.valid?).to eq true
    expect(@valid_user.admin).to eq false
  end

  it 'should have a country' do
    expect(@valid_user.valid?).to eq true
    expect(@valid_user.country).not_to eq nil
  end

  it 'without anything should not be valid' do
    invalid_user = User.create

    invalid_user.save
    expect(invalid_user.valid?).to eq false
  end

  it 'without a first_name should not be valid' do
    invalid_user = User.create(last_name: 'Roche', birthdate: @birthdate,
                               gender: 1,
                               email: 'thibaut.roche.perso2@gmail.com',
                               country: Country.first)

    expect(invalid_user.valid?).to eq false
  end

  it 'without a last_name should not be valid' do
    invalid_user = User.create(first_name: 'Thibaut', birthdate: @birthdate,
                               gender: 1,
                               email: 'thibaut.roche.perso2@gmail.com',
                               country: Country.first)

    expect(invalid_user.valid?).to eq false
  end

  it 'without birthdate should not be valid' do
    invalid_user = User.create(first_name: 'Thibaut', last_name: 'Roche',
                               gender: 1,
                               email: 'thibaut.roche.perso2@gmail.com',
                               country: Country.first)

    expect(invalid_user.valid?).to eq false
  end

  it 'should have more than 18 years old' do
    invalid_user = User.create(first_name: 'Thibaut',
                               birthdate: Date.new(1998, 02, 11), gender: 1,
                               email: 'thibaut.roche.perso2@gmail.com',
                               country: Country.first)

    expect(invalid_user.valid?).to eq false
  end

  it 'without gender should not be valid' do
    invalid_user = User.create(first_name: 'Thibaut', last_name: 'Roche',
                               birthdate: @birthdate,
                               email: 'thibaut.roche.perso2@gmail.com',
                               country: Country.first)

    expect(invalid_user.valid?).to eq false
  end
end
