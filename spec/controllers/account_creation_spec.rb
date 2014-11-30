require 'spec_helper'
require 'rails_helper'

describe 'The account creation page' do
  before :each do
    FactoryGirl.create(:france)
    FactoryGirl.create(:england)
    FactoryGirl.create(:usa)
    FactoryGirl.create(:canada)
    visit '/users/sign_up'
  end

  it 'should pass with a valid user' do
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
      fill_in :user_password_confirmation, with: attrs[:password_confirmation]
      click_on 'new_submit'
    end.to change(User, :count).by 1
  end

  it 'shouldn\'t accept a user without email' do
    attrs = FactoryGirl.attributes_for(:user)
    fill_in :user_first_name, with: attrs[:first_name]
    fill_in :user_last_name, with: attrs[:last_name]
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: attrs[:password]
    fill_in :user_password_confirmation, with: attrs[:password_confirmation]
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user without first name' do
    attrs = FactoryGirl.attributes_for(:user)
    fill_in :user_email, with: attrs[:email]
    fill_in :user_last_name, with: attrs[:last_name]
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: attrs[:password]
    fill_in :user_password_confirmation, with: attrs[:password_confirmation]
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user without last name' do
    attrs = FactoryGirl.attributes_for(:user)
    fill_in :user_email, with: attrs[:email]
    fill_in :user_first_name, with: attrs[:first_name]
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: attrs[:password]
    fill_in :user_password_confirmation, with: attrs[:password_confirmation]
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user without birthdate' do
    attrs = FactoryGirl.attributes_for(:user)
    fill_in :user_email, with: attrs[:email]
    fill_in :user_first_name, with: attrs[:first_name]
    fill_in :user_last_name, with: attrs[:last_name]
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    fill_in :user_password, with: attrs[:password]
    fill_in :user_password_confirmation, with: attrs[:password_confirmation]
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user with wrong password confirmation' do
    attrs = FactoryGirl.attributes_for(:user)
    fill_in :user_email, with: attrs[:email]
    fill_in :user_first_name, with: attrs[:first_name]
    fill_in :user_last_name, with: attrs[:last_name]
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: attrs[:password]
    fill_in :user_password_confirmation, with: 'okpkooijdzo'
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end
end
