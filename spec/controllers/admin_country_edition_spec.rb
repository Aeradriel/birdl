require 'spec_helper'
require 'rails_helper'

describe 'The admin country edition page' do
  def sign_in(user)
    user.confirm!
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @country = FactoryGirl.create(:france)
    @user = FactoryGirl.create(:admin)

    sign_in @user
    visit "/admin/countries/#{@country.id}/edit"
  end

  it 'should change name when filling the name' do
    fill_in 'country_name', with: 'England'
    click_button 'edit_submit'
    expect(Country.find(@country.id).name).to eq 'England'
  end

  it 'should change language when filling the name' do
    fill_in 'country_language', with: 'English'
    click_button 'edit_submit'
    expect(Country.find(@country.id).language).to eq 'English'
  end
end
