require 'spec_helper'
require 'rails_helper'

describe 'The account creation page' do
  before :each do
    Country.create!(name: 'France', language: 'Français',
                    flag_path: '/public/flag.png')
    Country.create!(name: 'England', language: 'English (GB)',
                    flag_path: '/public/flag.png')
    Country.create!(name: 'USA', language: 'English (US)',
                    flag_path: '/public/flag.png')
    Country.create!(name: 'Canada', language: 'Nawak',
                    flag_path: '/public/flag.png')

    visit '/users/sign_up'
  end

  it 'should pass with a valid user' do
    fill_in :user_email, with: 'thibaut.roche.perso@gmail.com'
    fill_in :user_first_name, with: 'Thibaut'
    fill_in :user_last_name, with: 'Roche'
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: 'passwordpourtest'
    fill_in :user_password_confirmation, with: 'passwordpourtest'
    click_on 'new_submit'
    expect(User.count).to eq 1
  end

  it 'shouldn\'t accept a user without email' do
    fill_in :user_first_name, with: 'Thibaut'
    fill_in :user_last_name, with: 'Roche'
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: 'passwordpourtest'
    fill_in :user_password_confirmation, with: 'passwordpourtest'
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user without first name' do
    fill_in :user_email, with: 'thibaut.roche.perso@gmail.com'
    fill_in :user_last_name, with: 'Roche'
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: 'passwordpourtest'
    fill_in :user_password_confirmation, with: 'passwordpourtest'
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user without last name' do
    fill_in :user_email, with: 'thibaut.roche.perso@gmail.com'
    fill_in :user_first_name, with: 'Thibaut'
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: 'passwordpourtest'
    fill_in :user_password_confirmation, with: 'passwordpourtest'
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user without birthdate' do
    fill_in :user_email, with: 'thibaut.roche.perso@gmail.com'
    fill_in :user_first_name, with: 'Thibaut'
    fill_in :user_last_name, with: 'Roche'
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    fill_in :user_password, with: 'passwordpourtest'
    fill_in :user_password_confirmation, with: 'passwordpourtest'
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end

  it 'shouldn\'t accept a user with wrong password confirmation' do
    fill_in :user_email, with: 'thibaut.roche.perso@gmail.com'
    fill_in :user_first_name, with: 'Thibaut'
    fill_in :user_last_name, with: 'Roche'
    select I18n.t(:male), from: 'user_gender'
    select 'Canada', from: 'user_country_id'
    select '1994', from: 'user_birthdate_1i'
    select I18n.t('date.month_names')[2], from: 'user_birthdate_2i'
    select '11', from: 'user_birthdate_3i'
    fill_in :user_password, with: 'passwordpourtest'
    fill_in :user_password_confirmation, with: 'passwordpourtest2'
    click_on 'new_submit'
    expect(page).to have_css('#error_explanation')
    expect(page).to have_css('.field_with_errors')
  end
end
