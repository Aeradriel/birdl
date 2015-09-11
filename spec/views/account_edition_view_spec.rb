require 'spec_helper'
require 'rails_helper'

describe 'The account edition page' do
  def sign_in(user)
    user.confirm
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @user = FactoryGirl.create(:user)

    sign_in @user
    visit '/users/edit'
  end

  it 'should contain edition form' do
    expect(page).to have_css('#edit_user')
  end

  it 'should contain email field' do
    expect(page).to have_css('#user_email')
  end

  it 'should contain first name field' do
    expect(page).to have_css('#user_first_name')
  end

  it 'should contain last name field' do
    expect(page).to have_css('#user_last_name')
  end

  it 'should contain birth date field' do
    expect(page).to have_css('#user_birthdate_1i')
    expect(page).to have_css('#user_birthdate_2i')
    expect(page).to have_css('#user_birthdate_3i')
  end

  it 'should contain birth date field that cannot accept under 18 years old' do
    actual_year = Time.now.year - 18
    while actual_year > Time.now.year - 100
      expect(page.has_select?('user_birthdate_1i',
                              with_options: ["#{actual_year}"])).to eq true
      actual_year -= 1
    end
  end

  it 'should contain gender field' do
    expect(page).to have_css('#user_gender')
  end

  it 'should contain country field' do
    expect(page).to have_css('#user_country_id')
  end

  it 'should contain password field' do
    expect(page).to have_css('#user_password')
  end

  it 'should contain password confirmation field' do
    expect(page).to have_css('#user_password_confirmation')
  end

  it 'should contain current password field' do
    expect(page).to have_css('#user_current_password')
  end

  it 'should contain submit button' do
    expect(page).to have_css('#userEdit_submit')
  end

  it 'should contain delete button' do
    expect(page).to have_css('.userEdit_del_button')
  end
end
