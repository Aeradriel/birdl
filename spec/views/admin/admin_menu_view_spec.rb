require 'spec_helper'
require 'rails_helper'

describe 'The admin menu' do
  def sign_in(user)
    user.confirm
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @user = FactoryGirl.create(:admin)

    sign_in @user
  end

  describe 'on dashboard' do
    before :each do
      visit '/admin'
    end

    it 'should contain dashboard' do
      expect(page).to have_css('#dashboard_link')
    end

    it 'should contain countries' do
      expect(page).to have_css('#countries_link')
    end

    it 'should contrain users' do
      expect(page).to have_css('#users_link')
    end
  end

  describe 'on country edit' do
    before :each do
      visit '/admin/countries'
    end

    it 'should contain dashboard' do
      expect(page).to have_css('#dashboard_link')
    end

    it 'should contain countries' do
      expect(page).to have_css('#countries_link')
    end

    it 'should contrain users' do
      expect(page).to have_css('#users_link')
    end
  end

  describe 'on user edit' do
    before :each do
      visit '/admin/users'
    end

    it 'should contain dashboard' do
      expect(page).to have_css('#dashboard_link')
    end

    it 'should contain countries' do
      expect(page).to have_css('#countries_link')
    end

    it 'should contrain users' do
      expect(page).to have_css('#users_link')
    end
  end
end
