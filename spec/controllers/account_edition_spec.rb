require 'spec_helper'
require 'rails_helper'

describe 'The account edition page' do
  def sign_in(user)
    user.confirm!
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @user = FactoryGirl.create(:user)

    sign_in @user
    visit '/users/edit'
  end

  it 'should raise an error when password is not provided' do
    click_button 'edit_submit'
    expect(page).to have_css('#error_explanation')
  end

  it 'should indicate the wrong field' do
    fill_in 'user_email', with: 'bonjour@lol.com'
    fill_in 'user_current_password', with: 'iudjeiuzdhuize'
    click_button 'edit_submit'
    expect(page).to have_css('.field_with_errors')
  end

  it 'should change unconfirmed address when filling the email form' do
    fill_in 'user_email', with: 'bonjour@lol.com'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    expect(User.find(@user.id).unconfirmed_email).to eq 'bonjour@lol.com'
  end

  it 'shouldn\'t change email address before it\'s confirmed' do
    fill_in 'user_email', with: 'bonjour@lol.com'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    expect(User.find(@user.id).email).to eq @user.email
  end

  it 'should change email address after confirmed the new address' do
    fill_in 'user_email', with: 'bonjour@lol.com'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    User.find(@user.id).confirm!
    expect(User.find(@user.id).email).to eq 'bonjour@lol.com'
  end

  it 'should change first name when editing in form' do
    fill_in 'user_first_name', with: 'Nouveau nom'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    expect(User.find(@user.id).first_name).to eq 'Nouveau nom'
  end

  it 'should change last name when editing in form' do
    fill_in 'user_last_name', with: 'Nouveau nom'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    expect(User.find(@user.id).last_name).to eq 'Nouveau nom'
  end

  it 'should change gender when editing in form' do
    select I18n.t(:female), from: 'user_gender'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    expect(User.find(@user.id).gender).to eq 0
  end

  it 'should change country when editing in form' do
    FactoryGirl.create(:england)
    FactoryGirl.create(:france)
    FactoryGirl.create(:canada)

    visit '/users/edit'
    select 'England', from: 'user_country_id'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    user = User.find(@user.id).country
    expect(user).to eq Country.where(name: 'England').first
  end

  it 'should change password when editing correctly it and its confirmation' do
    fill_in 'user_password', with: 'jemappelleguy'
    fill_in 'user_password_confirmation', with: 'jemappelleguy'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    expect(User.find(@user.id).valid_password?('jemappelleguy')).to eq true
  end

  it 'shouldn\'t change password when failing confirmation in form' do
    fill_in 'user_password', with: 'jemappelleguy'
    fill_in 'user_password_confirmation', with: 'iojojojojoi'
    fill_in 'user_current_password', with: @user.password
    click_button 'edit_submit'
    expect(User.find(@user.id).valid_password?('jemappelleguy')).to eq false
  end
end
