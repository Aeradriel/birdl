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
    @user = FactoryGirl.create(:admin)
    FactoryGirl.create(:france)
    FactoryGirl.create(:england)
    FactoryGirl.create(:usa)
    FactoryGirl.create(:canada)

    sign_in @user
    visit '/admin/users/new'
  end

  context 'with valid informations' do
    it 'should create new user with all infos' do
      attrs = FactoryGirl.attributes_for(:user)
      expect do
        fill_in :user_email, with: attrs[:email]
        fill_in :user_first_name, with: attrs[:first_name]
        fill_in :user_last_name, with: attrs[:last_name]
        select I18n.t(:male), from: 'user_gender'
        select 'Canada', from: 'user_country_id'
        select '1994', from: 'user_birthdate_1i'
        select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
        select '11', from: 'user_birthdate_3i'
        fill_in :user_password, with: attrs[:password]
        click_on 'new_submit'
      end.to change(User, :count).by 1
      expect(User.where(email: attrs[:email]).first).to_not eq nil
    end

    it 'should create new user without country' do
      attrs = FactoryGirl.attributes_for(:user)
      expect do
        fill_in :user_email, with: attrs[:email]
        fill_in :user_first_name, with: attrs[:first_name]
        fill_in :user_last_name, with: attrs[:last_name]
        select I18n.t(:male), from: 'user_gender'
        select '1994', from: 'user_birthdate_1i'
        select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
        select '11', from: 'user_birthdate_3i'
        fill_in :user_password, with: attrs[:password]
        click_on 'new_submit'
      end.to change(User, :count).by 1
      expect(User.where(email: attrs[:email]).first).to_not eq nil
    end
  end

  context 'with invlid informations' do
    it 'should not create new user without first_name' do
      attrs = FactoryGirl.attributes_for(:user)
      expect do
        fill_in :user_email, with: attrs[:email]
        fill_in :user_last_name, with: attrs[:last_name]
        select I18n.t(:male), from: 'user_gender'
        select 'Canada', from: 'user_country_id'
        select '1994', from: 'user_birthdate_1i'
        select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
        select '11', from: 'user_birthdate_3i'
        fill_in :user_password, with: attrs[:password]
        click_on 'new_submit'
      end.to change(User, :count).by 0
      expect(User.where(email: attrs[:email]).first).to eq nil
    end

    it 'should not create new user without last_name' do
      attrs = FactoryGirl.attributes_for(:user)
      expect do
        fill_in :user_email, with: attrs[:email]
        fill_in :user_first_name, with: attrs[:first_name]
        select I18n.t(:male), from: 'user_gender'
        select 'Canada', from: 'user_country_id'
        select '1994', from: 'user_birthdate_1i'
        select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
        select '11', from: 'user_birthdate_3i'
        fill_in :user_password, with: attrs[:password]
        click_on 'new_submit'
      end.to change(User, :count).by 0
      expect(User.where(email: attrs[:email]).first).to eq nil
    end

    it 'should not create new user without email' do
      attrs = FactoryGirl.attributes_for(:user)
      expect do
        fill_in :user_first_name, with: attrs[:first_name]
        fill_in :user_last_name, with: attrs[:last_name]
        select I18n.t(:male), from: 'user_gender'
        select 'Canada', from: 'user_country_id'
        select '1994', from: 'user_birthdate_1i'
        select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
        select '11', from: 'user_birthdate_3i'
        fill_in :user_password, with: attrs[:password]
        click_on 'new_submit'
      end.to change(User, :count).by 0
      expect(User.where(email: attrs[:email]).first).to eq nil
    end

    it 'should not create new user without password' do
      attrs = FactoryGirl.attributes_for(:user)
      expect do
        fill_in :user_email, with: attrs[:email]
        fill_in :user_first_name, with: attrs[:first_name]
        fill_in :user_last_name, with: attrs[:last_name]
        select I18n.t(:male), from: 'user_gender'
        select 'Canada', from: 'user_country_id'
        select '1994', from: 'user_birthdate_1i'
        select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
        select '11', from: 'user_birthdate_3i'
        click_on 'new_submit'
      end.to change(User, :count).by 0
      expect(User.where(email: attrs[:email]).first).to eq nil
    end

    it 'should not create new user without birthdate' do
      attrs = FactoryGirl.attributes_for(:user)
      expect do
        fill_in :user_email, with: attrs[:email]
        fill_in :user_first_name, with: attrs[:first_name]
        fill_in :user_last_name, with: attrs[:last_name]
        select I18n.t(:male), from: 'user_gender'
        select 'Canada', from: 'user_country_id'
        fill_in :user_password, with: attrs[:password]
        click_on 'new_submit'
      end.to change(User, :count).by 0
      expect(User.where(email: attrs[:email]).first).to eq nil
    end
  end
end
