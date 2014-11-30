require 'spec_helper'
require 'rails_helper'

describe 'A Country' do
  before :each do
    @country = FactoryGirl.create(:france)
  end

  it 'should not have an empty language' do
    bad_country = FactoryGirl.build(:france, language: '')
    expect(bad_country.valid?).to eq false
  end

  it 'should not be valid without language' do
    bad_country = FactoryGirl.build(:france, language: nil)
    expect(bad_country.valid?).to eq false
  end

  it 'should not have an empty name' do
    bad_country = FactoryGirl.build(:france, name: '')
    expect(bad_country.valid?).to eq false
  end

  it 'should not be valid without name' do
    bad_country = FactoryGirl.build(:france, name: nil)
    expect(bad_country.valid?).to eq false
  end

  it 'when deleted should reset its users country' do
    3.times do
      FactoryGirl.create(:user, country: @country)
    end

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
