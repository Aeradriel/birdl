require 'spec_helper'
require 'rails_helper'

describe 'User' do
  def sign_in(user)
    user.confirm!
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  context 'with unauthorized authenticated user', js: true do
    before :each do
      @user = FactoryGirl.create(:user)

      sign_in @user
    end

    it 'should not access to dashboard' do
    end
  end
end
