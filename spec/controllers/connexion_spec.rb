require 'spec_helper'
require 'rails_helper'

describe 'The connexion page' do
  before :each do
    @good_user = FactoryGirl.create(:user, confirmed_at: Time.zone.now)
    @user_not_validated = FactoryGirl.create(:user)
    visit '/login'
  end

  it 'should raise an error for bad ids' do
    within '#new_user' do
      fill_in 'user_email', with: 'lol@lol.lol'
      fill_in 'user_password', with: 'lol'
      click_on I18n.t(:sign_in)
    end
    expect(page).to have_css('.alert-danger')
  end

  it 'should raise an error for bad password' do
    within '#new_user' do
      fill_in 'user_email', with: @good_user.email
      fill_in 'user_password', with: 'lol'
      click_on I18n.t(:sign_in)
    end
    expect(page).to have_css('.alert-danger')
  end

  it 'should not allow login with unconfirmed address' do
    within '#new_user' do
      fill_in 'user_email', with: @user_not_validated
      fill_in 'user_password', with: 'liodzojdzol'
      click_on I18n.t(:sign_in)
    end
    expect(page).to have_css('.alert-danger')
  end

  it 'should allow login with good ids' do
    within '#new_user' do
      fill_in 'user_email', with: @good_user.email
      fill_in 'user_password', with: @good_user.password
      click_on I18n.t(:sign_in)
    end
    expect(page).to_not have_css('.alert-danger')
  end
end
