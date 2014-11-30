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

    sign_in @user
    visit '/admin/users/new'
  end
end
