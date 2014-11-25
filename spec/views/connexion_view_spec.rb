require 'spec_helper'
require 'rails_helper'

describe 'The connexion page' do
  before :each do
    visit '/login'
  end

  it 'should have a correct login form' do
    expect(page).to have_css('#new_user')
    expect(page).to have_css('#user_email')
    expect(page).to have_css('#user_password')
    expect(page).to have_css('#login_submit')
  end

  it 'should have a google sign in link' do
    pending 'Waiting for google authentication'
    expect(page).to have_css('#google_signin_link')
  end

  it 'should have a facebook sign in link' do
    pending('Waiting for facebook authentication')
    expect(page).to have_css('#facebook_signin_link')
  end

  it 'should have a sign up link' do
    expect(page).to have_css('#signup_link')
  end

  it 'should have a lost password link' do
    expect(page).to have_css('.pwd_button')
  end

  it 'should have a link to send confirmation email again' do
    expect(page).to have_css('#email_confirmation_link')
  end
end
