require 'spec_helper'
require 'rails_helper'

describe 'The account deletion button' do
  def sign_in(user)
    user.confirm!
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  def user_exists?
  end

  before :each do
    @country = Country.create!(name: 'France', language: 'Français',
                               flag_path: 'public/flags/french.jpg')
    @user = User.create!(first_name: 'Thibaut', last_name: 'Roche',
                         birthdate: Date.new(1994, 02, 11), gender: 1,
                         email: 'thibaut.roche.perso@gmail.com',
                         password: 'liodzojdzol',
                         password_confirmation: 'liodzojdzol',
                         country: Country.first, confirmed_at: Date.current)

    sign_in @user
    visit '/users/edit'
  end

  it 'should display an alert to confirm the deletion', js: true do
    click_on 'delete_submit'
    expect(page.driver.browser.switch_to.alert).to_not eq nil
  end

  it 'should not delete account when cancelling deletion', js: true do
    click_on 'delete_submit'
    page.driver.browser.switch_to.alert.dismiss
    expect(User.find(@user.id).id).to eq @user.id
  end

  it 'should delete account when confirming deletion', js: true do
    click_on 'delete_submit'
    page.driver.browser.switch_to.alert.accept
    visit '/'
    expect(User.count).to eq 0
  end

  it 'should delete/change events of the user after deletion' do
    pending 'Waiting for event implementation'
    expect(1).to eq 2
  end

  it 'should remove user from event he takes part after deletion' do
    pending 'Waiting for event implementation'
    expect(1).to eq 2
  end

  it 'should delete relations with the user after deletion' do
    pending 'Waiting for relations implementation'
    expect(1).to eq 2
  end

  it 'should delete calendars of the user after deletion' do
    pending 'Waiting for calendars implementation'
    expect(1).to eq 2
  end

  it 'should delete ratings of the user after deletion' do
    pending 'Waiting for ratings implementation'
    expect(1).to eq 2
  end

  it 'should delete badges of the user after deletion' do
    pending 'Waiting for badges implementation'
    expect(1).to eq 2
  end

  it 'should delete badges progression of the user after deletion' do
    pending 'Waiting for calendars implementation'
    expect(1).to eq 2
  end
end
