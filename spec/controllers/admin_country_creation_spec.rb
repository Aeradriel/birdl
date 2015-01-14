require 'spec_helper'
require 'rails_helper'

describe 'The admin country creation page' do
  def sign_in(user)
    user.confirm!
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @user = FactoryGirl.create(:admin)

    sign_in @user
    visit '/admin/countries/new'
  end

  context 'with valid informations' do
    it 'should create new user with all infos' do
      attrs = FactoryGirl.attributes_for(:france)
      expect do
        fill_in :country_name, with: attrs[:name]
        fill_in :country_language, with: attrs[:language]
        click_on 'new_submit'
      end.to change(Country, :count).by 1
    end
  end

  context 'with invalid informations' do
    it 'should not create new country without name' do
      attrs = FactoryGirl.attributes_for(:france)
      expect do
        fill_in :country_language, with: attrs[:language]
        click_on 'new_submit'
      end.to change(Country, :count).by 0
    end

    it 'should not create new country without language' do
      attrs = FactoryGirl.attributes_for(:france)
      expect do
        fill_in :country_name, with: attrs[:name]
        click_on 'new_submit'
      end.to change(Country, :count).by 0
    end
  end
end
