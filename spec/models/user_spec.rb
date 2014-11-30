require 'spec_helper'
require 'rails_helper'

describe 'A User' do
  before :each do
    Country.create(name: 'France', language: 'Français',
                   flag_path: 'public/flags/french.jpg')
    @valid_user = FactoryGirl.create(:user)
  end

  it 'should have a non-blank first name' do
    invalid_user = FactoryGirl.build(:user, first_name: '')
    expect(invalid_user.valid?).to eq false
  end

  it 'should have a last name' do
    expect(@valid_user.last_name).to eq 'Roche'
    expect(@valid_user.valid?).to eq true
  end

  it 'should have a non-blank last name' do
    invalid_user = FactoryGirl.build(:user, last_name: '')
    expect(invalid_user.valid?).to eq false
  end

  it 'should have a gender' do
    expect(@valid_user.gender).not_to eq nil
    expect(@valid_user.valid?).to eq true
  end

  it 'should have a valid gender' do
    user = FactoryGirl.build(:user)

    1000.times do
      user.gender = rand(-100..100)
      if user.gender == 1 || user.gender == 0
        expect(user.valid?).to eq true
      else
        expect(user.valid?).to eq false
      end
    end
  end

  it 'should not be admin' do
    expect(@valid_user.admin).to eq false
    expect(@valid_user.valid?).to eq true
  end

  it 'should not have a country by default' do
    expect(@valid_user.country).to eq nil
    expect(@valid_user.valid?).to eq true
  end

  it 'without a first_name should not be valid' do
    invalid_user = FactoryGirl.build(:user, first_name: nil)
    expect(invalid_user.valid?).to eq false
  end

  it 'without a last_name should not be valid' do
    invalid_user = FactoryGirl.build(:user, last_name: nil)
    expect(invalid_user.valid?).to eq false
  end

  it 'without birthdate should not be valid' do
    invalid_user = FactoryGirl.build(:user, birthdate: nil)

    expect(invalid_user.valid?).to eq false
  end

  it 'should have more than 18 years old' do
    invalid_user = FactoryGirl.build(:user, birthdate: 12.years.ago)
    expect(invalid_user.valid?).to eq false
  end

  it 'without gender should not be valid' do
    invalid_user = FactoryGirl.build(:user, gender: nil)
    expect(invalid_user.valid?).to eq false
  end
end
